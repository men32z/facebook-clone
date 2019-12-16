# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the PagesHelper. For example:
#
# describe PagesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe PagesHelper, type: :helper do
  let(:base_title) { 'Facebook Clone' }

  it 'should return the title' do
    expect(full_title).to eq(base_title)
  end

  it 'should return the title plus the title sended as a parameter' do
    example_text = 'Example'
    expect(full_title(example_text)).to eq(example_text + ' | ' + base_title)
  end
end
