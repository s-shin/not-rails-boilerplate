FactoryGirl.define do
  factory :message, class: App::Models::Message do
    name 'alice'
    title 'hello'
    body 'world'
  end

  to_create do |instance|
    instance.id = DB::Mapper.use(App::Context.instance.db_w).insert(instance)
  end
end
