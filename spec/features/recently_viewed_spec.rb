RSpec.feature 'Recently Viewed Products', :js do
  background do
    %w(Mug Shirt Jersey).each { |name| create(:product, name: name.to_s) }
    create(:store, default: true)
  end

  scenario 'keep track of recently viewed products', js: true do
    if Spree.version.to_f < 4.1
      visit spree.root_path
      click_link 'Mug'
      wait_for_ajax
      click_link 'Home'
      click_link 'Jersey'
      wait_for_ajax
      click_link 'Home'
      within(:css, 'ul#recently_viewed_products') do
        expect(page).to have_text 'Mug'
        expect(page).to have_text 'Jersey'
      end
    end
  end
end
