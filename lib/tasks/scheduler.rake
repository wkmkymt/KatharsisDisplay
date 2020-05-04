desc "This task is called by the Heroku scheduler add-on"

task :checkout_all_user => :environment do
  CheckinRecord.all.where(check_in: "in").each do |record|
    record.checkout
  end
end