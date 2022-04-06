# frozen_string_literal: true

RSpec.describe ArPrettySql do
  it "has a version number" do
    expect(ArPrettySql::VERSION).not_to be nil
  end

  context "when formatting" do
    it "can do it with colour" do
      dummy_relation = DummyRelation.new
      expect(dummy_relation.to_pretty_sql(format: true, color: true)).to eq(
        "\e[38;5;28;01mSELECT\e[39;00m\e[38;5;250m\e[39m\n\e[38;5;250m        \e[39m\e[38;5;236m*\e[39m\e[38;5;250m\e[39m\n\e[38;5;250m    \e[39m\e[38;5;28;01mFROM\e[39;00m\e[38;5;250m\e[39m\n\e[38;5;250m        \e[39m\e[38;5;250musers\e[39m\e[38;5;250m\e[39m\n\e[38;5;250m    \e[39m\e[38;5;28;01mWHERE\e[39;00m\e[38;5;250m\e[39m\n\e[38;5;250m        \e[39m\e[38;5;250mname\e[39m\e[38;5;250m \e[39m\e[38;5;28;01mLIKE\e[39;00m\e[38;5;250m \e[39m\e[48;5;15m'%Geoff'\e[49m\e[38;5;250m\e[39m\n\e[38;5;250m        \e[39m\e[38;5;28;01mAND\e[39;00m\e[38;5;250m \e[39m\e[38;5;250mage\e[39m\e[38;5;250m \e[39m\e[38;5;236m<=\e[39m\e[38;5;250m \e[39m\e[38;5;20;01m23\e[39;00m\e[38;5;250m\e[39m\n\e[38;5;250m    \e[39m\e[38;5;28;01mORDER\e[39;00m\e[38;5;250m \e[39m\e[38;5;28;01mBY\e[39;00m\e[38;5;250m\e[39m\n\e[38;5;250m        \e[39m\e[38;5;250mid\e[39m\e[38;5;250m \e[39m\e[38;5;28;01mASC\e[39;00m\e[38;5;250m \e[39m\e[38;5;28;01mLIMIT\e[39;00m\e[38;5;250m \e[39m\e[38;5;20;01m10\e[39;00m\e[38;5;250m\e[39m\n\e[38;5;250m\e[39m"
      )
    end

    it "can do it without colour" do
      dummy_relation = DummyRelation.new
      expect(dummy_relation.to_pretty_sql(format: true, colour: false)).to eq(
        "SELECT\n        *\n    FROM\n        users\n    WHERE\n        name LIKE '%Geoff'\n        AND age <= 23\n    ORDER BY\n        id ASC LIMIT 10\n"
      )
    end
  end

  it "can colour without formatting" do
    dummy_relation = DummyRelation.new
    expect(dummy_relation.to_pretty_sql(color: true, format: false)).to eq(
      "\e[38;5;28;01mSELECT\e[39;00m\e[38;5;250m \e[39m\e[38;5;236m*\e[39m\e[38;5;250m \e[39m\e[38;5;28;01mFROM\e[39;00m\e[38;5;250m \e[39m\e[38;5;250musers\e[39m\e[38;5;250m \e[39m\e[38;5;28;01mWHERE\e[39;00m\e[38;5;250m \e[39m\e[38;5;250mname\e[39m\e[38;5;250m \e[39m\e[38;5;28;01mlike\e[39;00m\e[38;5;250m \e[39m\e[48;5;15m'%Geoff'\e[49m\e[38;5;250m \e[39m\e[38;5;28;01mAND\e[39;00m\e[38;5;250m \e[39m\e[38;5;250mage\e[39m\e[38;5;250m \e[39m\e[38;5;236m<=\e[39m\e[38;5;250m \e[39m\e[38;5;20;01m23\e[39;00m\e[38;5;250m \e[39m\e[38;5;28;01mORDER\e[39;00m\e[38;5;250m \e[39m\e[38;5;28;01mBY\e[39;00m\e[38;5;250m \e[39m\e[38;5;250mid\e[39m\e[38;5;250m \e[39m\e[38;5;28;01mASC\e[39;00m\e[38;5;250m \e[39m\e[38;5;28;01mLIMIT\e[39;00m\e[38;5;250m \e[39m\e[38;5;20;01m10\e[39;00m\e[38;5;250m\e[39m\n\e[38;5;250m\e[39m"
    )
  end

  it "can be configured" do
    ArPrettySql.configure do |config|
      config.color = true
      config.format = false
      config.additional_sql_functions = []
    end

    expect(ArPrettySql::Config.color).to be true
    expect(ArPrettySql::Config.format).to be false
    expect(ArPrettySql::Config.additional_sql_functions).to be_empty
    expect(ArPrettySql::Config.keyword_case).to eq :upper
    expect(ArPrettySql::Config.theme).to be_a Rouge::Theme
  end
end
