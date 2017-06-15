require 'rails_helper'

feature 'Admin creates a new user' do
  scenario 'as admin create user without roles' do
    user = create(:user, :admin)

    sign_in(user.email, user.password)
    visit new_admin_user_path

    page.fill_in('Email', with: 'james@test.com')
    page.fill_in('user[password]', with: 'asdfjkl123')
    page.fill_in('user[password_confirmation]', with: 'asdfjkl123')
    page.click_on('Create User')

    expect(page).to have_content('Listing Users')
    expect(page).to have_content('james@test.com')
  end
  scenario 'as admin creates user with roles' do
    user = create(:user, :admin)

    sign_in(user.email, user.password)
    visit new_admin_user_path

    page.fill_in('First name', with: 'Penny')
    page.fill_in('Last name', with: 'A')
    page.check('user_roles_manager')
    page.check('user_roles_admin')
    page.fill_in('Email', with: 'penny@test.com')
    page.fill_in('user[password]', with: 'asdfjkl123')
    page.fill_in('user[password_confirmation]', with: 'asdfjkl123')
    page.click_on('Create User')

    expect(page).to have_content('Listing Users')
    expect(page).to have_content('penny@test.com')
    expect(page).to have_content('admin')
    expect(page).to have_content('manager')
  end
end
