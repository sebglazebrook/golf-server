require_relative "../../config/application"
require "repositories/user_repository"

describe Repositories::UserRepository do

  describe ".create!" do

    let(:data) do
      { username: "superman", }
    end
    let(:user) { Models::User.new(data) }

    subject { described_class.create!(data) }

    before do
      allow(Models::User).to receive(:new).with(data).and_return(user)
      described_class.reload!
    end

    it "creates a model of the user" do
      expect(Models::User).to receive(:new).with(data).and_return(user)
      subject
    end

    it "saves the user to the data store" do
      subject
      expect(described_class.send(:data_store).last).to eq user
    end

    it "returns the model" do
      expect(subject).to eq user
    end
  end

  describe ".save!" do

    let(:user) { Models::User.new(username: "superman", age: 30) }
    subject { described_class.save!(user) }

    context "if the user already exists?" do

      let(:old_user) { Models::User.new(username: "superman", age: 29) }
      before do
        described_class.save!(old_user)
      end

      it "updates the user in the data store" do
        subject
        expect(described_class.find!("superman").age).to eq 30
      end
    end

    context "if the user does NOT exist" do

      it "creates the user to the data store" do
        subject
        expect(described_class.find!("superman"))
      end
    end

    describe ".find!" do

      subject { described_class.find!(username) }

      context "when the user exists" do

        let(:username) { "superman" }

        before do
          described_class.create!(username: username)
        end
      
        it "returns a model of the user" do
          expect(subject.username).to eq username
        end
      end

      context "when the user does NOT exist" do

        let(:username) { "wonder woman" }

        it "raises an exception" do
          expect{ subject }.to raise_exception UnknownUser
        end
      end
    end
  end
end
