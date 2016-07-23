class InitDb < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text       :content, null: false
      t.boolean    :read, default: false
      t.references :sender, null: false
      t.references :receiver, null: false
      t.datetime   :read_at

      t.timestamps null: false
    end

    create_table :contacts do |t|
      t.references :owner, null: false
      t.references :member, null: false
      t.datetime   :last_call_time
    end
  end
end
