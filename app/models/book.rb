class Book < ApplicationRecord
    generate_public_uid generator: PublicUid::Generators::HexStringSecureRandom.new(16)
end
