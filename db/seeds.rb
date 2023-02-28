password = "User2023"
users = [
  { first_name: "Tam", last_name: "Nguyen", email: "tam@example.com" },
  { first_name: "Tram", last_name: "Nguyen", email: "tram@example.com" },
  { first_name: "Son", last_name: "Nguyen", email: "son@example.com" },
  { first_name: "Duy", last_name: "Ngo", email: "duy@example.com" },
  { first_name: "Vui", last_name: "Le", email: "vui@example.com" },
]
users.each do |item|
  user = User.where(email: item[:email]).first_or_create do |new_user|
    new_user.first_name = item[:first_name]
    new_user.last_name = item[:last_name]
    new_user.email = item[:email]
    new_user.password = password
    new_user.password_confirmation = password
    new_user.confirmed_at = DateTime.now
  end
  puts "[*] created new user id: #{user.id}; name: #{user.name}; email: #{user.email}"
end

u1 = User.find_by_email('tam@example.com')
u2 = User.find_by_email('tram@example.com')
u3 = User.find_by_email('son@example.com')
u1.follow(u2)
u1.follow(u3)
# u1.unfollow(u3)