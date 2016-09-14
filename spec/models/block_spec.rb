require 'rails_helper'

def create_website(url)
  website = Website.create(account: Account.new, name: 'Test Site', domain_url: url, theme: 'basic')
  return website
end

RSpec.describe Block, type: :model do
  it "returns correct blocks_splice_calc" do
    website = Website.create(account: Account.new, name: 'Test Site', theme: 'basic')
    block = Block.new(website: website, block_type: 'container', location:'bottom', text_align:'center')

    expect(block.blocks_splice_calc).to eq(3)

    Block.create!(block: block, website: website, block_type: 'sub_block', text_align:'center', location: 'bottom')

    expect(block.blocks_splice_calc).to eq(1)

    Block.create!(block: block, website: website, block_type: 'sub_block', text_align:'center', location: 'bottom')

    expect(block.blocks_splice_calc).to eq(2)

    Block.create!(block: block, website: website, block_type: 'sub_block', text_align:'center', location: 'bottom')

    expect(block.blocks_splice_calc).to eq(3)

    Block.create!(block: block, website: website, block_type: 'sub_block', text_align:'center', location: 'bottom')

    expect(block.blocks_splice_calc).to eq(4)

    Block.create!(block: block, website: website, block_type: 'sub_block', text_align:'center', location: 'bottom')

    expect(block.blocks_splice_calc).to eq(3)

    Block.create!(block: block, website: website, block_type: 'sub_block', text_align:'center', location: 'bottom')

    expect(block.blocks_splice_calc).to eq(3)

    Block.create!(block: block, website: website, block_type: 'sub_block', text_align:'center', location: 'bottom')

    expect(block.blocks_splice_calc).to eq(4)

    # block.blocks.create(website: website)
  end
end
