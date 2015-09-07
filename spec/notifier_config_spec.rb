require 'rspec'

describe NotifierConfig do
  let(:config) { NotifierConfig.new('spec/fixtures/config/notifications.yml') }

  describe "#notifications_for" do
    context "when project" do
      it "is not in notification.yml" do
        config.notifications_for('not_exist', :minus_one).should == :group
      end

      it "is in notifications.yml" do
        config.notifications_for('test', :plus_one).should == :group
        config.notifications_for('test', :jenkins_success).should == :none
        config.notifications_for('test', :minus_one).should == :individual
      end
    end

    context 'when notification' do
      it "is not in notifications.yml" do
        config.notifications_for('test', :not_exist).should == :group
      end
    end
  end

  describe '#include_ignore_string?' do
    context 'when target' do
      it 'is not include ignore string' do
        config.include_ignore_string?('test', 'hoge').should be false
      end

      it 'is include ignore string' do
        config.include_ignore_string?('test', 'hoge foo').should be true
      end
    end
  end

  describe '#ignore_strings' do
    context 'when project' do
      it 'is not in notification.yml' do
        config.ignore_strings('not_exist').should == []
      end

      it 'is not in notification.yml' do
        config.ignore_strings('test').should include 'ignore string'
        config.ignore_strings('test').should include 'foo'
      end
    end
  end
end
