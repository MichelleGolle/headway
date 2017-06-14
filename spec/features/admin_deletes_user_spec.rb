require 'rails_helper'

feature 'Admin deletes user' do
  scenario 'as admin' do
    admin = create(:user, :admin)
    user = create(:user)

    sign_in(admin.email, admin.password)
    visit admin_users_path


    page.find_link('Destroy', href: "/admin/users/#{user.id}").click

    expect(page).not_to have_content("#{user.email}")
  end
end
