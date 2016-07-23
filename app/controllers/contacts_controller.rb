# -*- coding: utf-8 -*-
class ContactsController < ApplicationController
  def index
    @contacts = Contact.where("owner_id=?", current_user.id).order("last_call_time desc").limit(20)
  end

  def new
    @contact = Contact.new
  end

  def create
    user = User.find_by_email params[:email]
    if user.nil?
      flash[:notice] = "用户不存在"
      render :new
      return
    end

    @contact = current_user.add_contact(user)

    # [todo] 需要对方同意才能加为联系人
    user.add_contact(current_user)

    redirect_to list_messages_path(friend_id: @contact.member_id)
  end

  def destroy
    @contact = Contact.find params[:id]
    @contact.destroy
    redirect_to contacts_path
  end
end
