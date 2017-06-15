require 'rails_helper'

feature 'Admin edits a user' do
  scenario 'to add roles' do
    admin = create(:user, :admin)
    user = create(:user)

    sign_in(admin.email, admin.password)

    visit edit_admin_user_path(user)

    page.check('user_roles_manager')
    page.click_on('Update User')

    expect(page).to have_content('Listing Users')
    expect(page).to have_content('manager')
    expect(page).to have_content(user.first_name)
  end

  scenario 'can edit to remove roles' do
    admin = create(:user, :admin)
    user = create(:user, :manager)

    sign_in(admin.email, admin.password)

    visit edit_admin_user_path(user)

    page.fill_in('First name', with: 'Penny')
    page.fill_in('Email', with: 'Penny@test.com')
    page.uncheck('user_roles_manager')
    page.click_on('Update User')

    expect(page).to have_content('Listing Users')
    expect(page).to have_content('Penny')
    expect(page).to_not have_content('manager')
  end
end
