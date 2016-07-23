class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :sent_messages, as: :sender
  has_many :received_messages, as: :receiver
  has_many :contacts, foreign_key: 'owner_id'

  def label_name
    email
  end

  def add_contact(member)
    contact = self.contacts.where(member_id: member.id).first
    if contact.nil?
      contact = self.contacts.build member_id: member.id
      contact.save!
    end
    contact
  end
end
