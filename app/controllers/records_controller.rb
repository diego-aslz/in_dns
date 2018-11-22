class RecordsController < ApplicationController
  has_scope :by_hostnames, as: :hostnames, type: :array
  has_scope :except_hostnames, type: :array
  has_scope :page

  before_action :ensure_page, only: :index

  def index
    @records = apply_scopes(Record.all).preload(:hosts)
    @records_by_hostname = Host.group_records_by_name(@records)
    @records_by_hostname = @records_by_hostname.except(*params[:hostnames]) if params[:hostnames].present?
  end

  def create
    done = false
    begin
      Record.transaction do
        begin
          # `find_or_create_by` is not threadsafe because a given thread B might create the Host X right after given
          # thread A checked for its existence. In that scenario, we're gonna get an ActiveRecord::RecordNotUnique
          # exception.
          host_ids = params[:hostnames].map { |name| Host.find_or_create_by(name: name).id }
        rescue ActiveRecord::RecordNotUnique
          # When a race condition happens, we just rollback this transaction and let the loop retry it.
          raise ActiveRecord::Rollback
        end

        @record = Record.new(ip: params[:ip], host_ids: host_ids)
        @errors = @record.errors.full_messages unless @record.save

        done = true
      end
    end until done
  end

  protected

  def ensure_page
    return if params[:page].to_i > 0
    render status: 400, json: { error: 'Missing "page" parameter' }
  end
end
