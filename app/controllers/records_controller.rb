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
  end

  protected

  def ensure_page
    return if params[:page].to_i > 0
    render status: 400, json: { error: 'Missing "page" parameter' }
  end
end
