#!/usr/bin/ruby
# frozen_string_literal: true

require 'net/http'
require 'securerandom'
require 'json'

class SeedData
  def self.characters
    [
      { first_name: 'Bebe', last_name: 'Stevens' },
      { first_name: 'Heidi', last_name: 'Turner' },
      { first_name: 'Jessica', last_name: 'Makinson' },
      { first_name: 'Scott', last_name: 'Malkinson' },
      { first_name: 'Timmy', last_name: 'Burch' },
      { first_name: 'Tweek', last_name: 'Tweak' },
      { first_name: 'PC', last_name: 'Principal' },
      { first_name: 'Strong', last_name: 'Woman' },
      { first_name: 'Jessica', last_name: 'Makinson' },
      { first_name: 'Sharon', last_name: 'Marsh' },
      { first_name: 'Shelley', last_name: 'Marsh' },
      { first_name: 'Jimbo', last_name: 'Kern' },
      { first_name: 'Ike', last_name: 'Broflovski' },
      { first_name: 'Stuart', last_name: 'McCormick' },
      { first_name: 'Carol', last_name: 'McCormick' },
      { first_name: 'Karen', last_name: 'McCormick' },
      { first_name: 'Stephen', last_name: 'Stotch' },
      { first_name: 'Linda', last_name: 'Stotch' },
      { first_name: 'Officer', last_name: 'Barbrady' },
      { first_name: 'Ned', last_name: 'Gerblansky' },
      { first_name: 'Father', last_name: 'Maxi' },
      { first_name: 'Catholic', last_name: 'priest' },
      { first_name: 'Harrison', last_name: 'Yates' },
      { first_name: 'Pip', last_name: 'Pirrup' },
      { first_name: 'Betsy', last_name: 'Donovan' },
      { first_name: 'Saddam', last_name: 'Hussein' },
      { first_name: 'Principal', last_name: 'Victoria' },
      { first_name: 'Kevin', last_name: 'Stoley' },
      { first_name: 'Matt', last_name: 'Stone' },
      { first_name: 'Jason', last_name: 'White' },
      { first_name: 'Darryl', last_name: 'Weathers' },
      { first_name: 'Trey', last_name: 'Parker' },
      { first_name: 'Bradley', last_name: 'Biggle' }
    ]
  end

  def self.items
    [
      { description: 'Fatty Doo Doo DVD', price: 0.8 },
      { description: 'Guzungas Gentlemans Magazine', price: 0.7 },
      { description: 'The Spirit of Christmas Film Reel', price: 0.8 },
      { description: 'VHS What Are These Changes? VHS', price: 0.4 },
      { description: 'What Happened To My School', price: 1.0 },
      { description: 'A Bowl of Craft Dinner', price: 0.5 },
      { description: 'Afghani Goat', price: 4.0 },
      { description: 'Alabama Man', price: 0.5 },
      { description: 'Antonio Banderas Love Doll', price: 0.7 },
      { description: 'Asses of Fire 2 poster', price: 0.2 },
      { description: 'BFF Necklace', price: 0.4 },
      { description: 'Baby Fark McGee-zaxs Broken Pistol', price: 1.2 },
      { description: 'VHS Backdoor Sluts 9', price: 0.9 },
      { description: 'Backdoor Tickler', price: 0.4 },
      { description: 'Barry Bonds Bat', price: 0.7 },
      { description: 'Bass Guitar', price: 1.0 },
      { description: 'Battered Shield', price: 0.35 },
      { description: 'Big Mamba Condoms', price: 0.5 },
      { description: 'Biggest Douche Award', price: 0.8 },
      { description: 'Blob of Stem Cells', price: 0.6 },
      { description: 'Bottle Cap', price: 0.2 },
      { description: 'Bottle of Sunscreen', price: 0.2 },
      { description: 'Bowling Trophy', price: 0.8 },
      { description: 'Boy Band Photo', price: 0.1 },
      { description: 'Boy-sized Leash', price: 0.25 },
      { description: 'Brad Pitt Survival Gear Kit', price: 1.2 },
      { description: 'Broken Bottle', price: 0.1 },
      { description: 'Broken Chain', price: 0.1 },
      { description: 'Broken Gnome Pick', price: 0.3 },
      { description: 'Broken Sword Hilt', price: 0.25 },
      { description: 'Bruce Vilanch Headshot', price: 0.4 },
      { description: 'Butters Creamy Goo', price: 0.5 },
      { description: 'Cafeteria Fraiche', price: 0.15 },
      { description: 'Calculator', price: 0.6 },
      { description: 'Canadian Adoption Papers', price: 0.3 },
      { description: 'Canadian Gemstone', price: 0.6 },
      { description: 'Canadian Treasure', price: 5.0 },
      { description: 'Cardboard Roll', price: 0.2 },
      { description: 'Ceramic Shard', price: 0.15 },
      { description: 'Charm Bracelet', price: 0.15 },
      { description: 'Cherokee Hair Tampon', price: 0.3 },
      { description: 'Chicken Bones', price: 0.05 },
      { description: 'Cloth Fragment', price: 0.1 },
      { description: 'Clydes Rulebook', price: 0.3 },
      { description: 'Coon Poster', price: 0.25 },
      { description: 'Crack Pipe', price: 0.3 },
      { description: 'Crank Prank Time Phone', price: 1.6 },
      { description: 'Crumpled Lantern', price: 0.25 },
      { description: 'Crumpled Paper', price: 0.05 },
      { description: 'Cyborg Bill Action Figure', price: 0.6 },
      { description: 'DMV Literature', price: 0.4 },
      { description: 'Destroyed Laser Pistol', price: 1.0 },
      { description: 'Dire Claw', price: 0.4 },
      { description: 'Dire Heart', price: 0.15 },
      { description: 'Dire Scale', price: 0.1 },
      { description: 'Dreidel', price: 0.3 },
      { description: 'Elf Ear', price: 0.5 },
      { description: 'Empty Glue Bottle', price: 0.05 },
      { description: 'Faith +1 CD', price: 0.4 },
      { description: 'Fish Sticks', price: 0.3 },
      { description: 'Five-Fingered Fister', price: 0.5 },
      { description: 'Fork', price: 0.1 },
      { description: 'Fractured Bulb', price: 0.2 },
      { description: 'Fractured Slingshot', price: 0.3 },
      { description: 'GSM Button', price: 0.05 },
      { description: 'Girls List', price: 0.15 },
      { description: 'Glass Shard', price: 0.15 },
      { description: 'Glowing Crystal Fragment', price: 0.25 },
      { description: 'Glowing Goo', price: 0.35 },
      { description: 'Gnome Teeth', price: 0.1 },
      { description: 'Guinea Pig Costume', price: 0.6 },
      { description: 'Hawaiian ID Card', price: 0.4 },
      { description: 'Head of the Powell Statue', price: 1.6 },
      { description: 'Highlighter', price: 0.08 },
      { description: 'Honey Boo Boos Pig Heart', price: 0.3 },
      { description: 'Ice Cream', price: 0.15 },
      { description: 'Ikes Chewing Tobacco', price: 0.5 },
      { description: 'Ikes Love Drawing', price: 0.3 },
      { description: 'Inspector Butters Badge', price: 0.6 },
      { description: 'Intellilink Manual', price: 0.5 },
      { description: 'Jack Rabbit', price: 0.4 },
      { description: 'Jew Scout Guide', price: 0.3 },
      { description: 'Jump Rope', price: 0.4 },
      { description: 'Lil Crime Stopper Badges', price: 0.8 },
      { description: 'Lil Minis Condoms', price: 0.3 },
      { description: 'Lion King DVD', price: 0.5 },
      { description: 'Macaroni Pictures', price: 0.3 },
      { description: 'Mahalo Rewards Card', price: 0.4 },
      { description: 'Maple Leaf', price: 0.15 },
      { description: 'Marker', price: 0.1 },
      { description: 'Medical Marijuana Card', price: 0.3 },
      { description: 'Metrosexual Hair Gel', price: 0.4 },
      { description: 'Microchip', price: 0.4 },
      { description: 'Mr. Hankey Construction Set', price: 0.7 },
      { description: 'Mr. Mackeys Coffee Mug', price: 0.5 },
      { description: 'Mr. Twig', price: 0.8 },
      { description: 'Mysterion Picture', price: 0.5 },
      { description: 'NAMBLA Calendar', price: 0.5 },
      { description: 'NASCAR Members Club ID', price: 0.3 },
      { description: 'Needle-sharp Dire Fang', price: 0.15 },
      { description: 'Needle-sharp Fang', price: 0.15 },
      { description: 'No. 2 Pencil', price: 0.05 },
      { description: 'Okama Gamesphere', price: 2.0 },
      { description: 'Old Baseball Glove', price: 0.25 },
      { description: 'Old Sponge', price: 0.1 },
      { description: 'Packet of Sea People', price: 0.5 },
      { description: 'Penis Composite Sketch', price: 0.2 },
      { description: 'Phil Collins Oscar', price: 0.9 },
      { description: 'Philip Action Figure', price: 0.3 },
      { description: 'Picture of Mr. Adlers Fiance', price: 0.2 },
      { description: 'Picture of Nichole', price: 0.15 },
      { description: 'Picture of Wendy', price: 0.5 },
      { description: 'Pile of Splinters', price: 0.05 },
      { description: 'Pinewood Derby Car', price: 0.4 },
      { description: 'Pixelated Shard', price: 0.31 },
      { description: 'Popcorn Necklaces', price: 0.25 },
      { description: 'Positive Queefy Sore Test', price: 0.3 },
      { description: 'Pubes', price: 0.05 },
      { description: 'Purity Ring', price: 0.5 },
      { description: 'Raisins Girl Picture', price: 0.35 },
      { description: 'Reach For The Skyler CD', price: 0.4 },
      { description: 'Rectal Photography Kit', price: 0.5 },
      { description: 'Ripped Boot', price: 0.2 },
      { description: 'Roll of Tin Foil', price: 0.6 },
      { description: 'Rusty Pipe', price: 0.25 },
      { description: 'Smores Schnapps', price: 0.5 },
      { description: 'STANground Scause', price: 0.4 },
      { description: 'Safety Scissors', price: 0.2 },
      { description: 'Sarcastaball Trophy', price: 0.7 },
      { description: 'School Book', price: 0.4 },
      { description: 'Screwdriver', price: 0.3 },
      { description: 'Sea-Man Action Figure', price: 0.6 },
      { description: 'Shattered Arrow', price: 0.15 },
      { description: 'Shattered Scimitar Blade', price: 0.35 },
      { description: 'Shredded Plastic', price: 0.35 },
      { description: 'Small Locket', price: 0.8 },
      { description: 'Small Paw', price: 0.2 },
      { description: 'Soap on a Rope', price: 0.4 },
      { description: 'Space Cash', price: 1.0 },
      { description: 'Sparkeys Leash', price: 0.3 },
      { description: 'Spider Limb', price: 0.1 },
      { description: 'Spiked Wristband', price: 0.15 },
      { description: 'Spoiled City Sushi', price: 0.15 },
      { description: 'Spoiled Clamato Juice', price: 0.2 },
      { description: 'Spoiled Royal Pudding', price: 0.5 },
      { description: 'Spoon', price: 0.1 },
      { description: 'Squished Eyeball', price: 0.35 },
      { description: 'St. Peter', price: 1.0 },
      { description: 'Strange Tamer', price: 0.6 },
      { description: 'Striped Straw', price: 0.05 },
      { description: 'Stupid Spoiled Whore Doll', price: 0.2 },
      { description: 'Sunbrella', price: 0.4 },
      { description: 'Sunshine Sparkle Stickers', price: 0.05 },
      { description: 'Super Phun Thyme Tickets', price: 0.3 },
      { description: 'TV Award', price: 0.7 },
      { description: 'Tap Shoes', price: 0.6 },
      { description: 'Terrance Action Figure', price: 0.3 },
      { description: 'The Poop that Took a Pee', price: 0.6 },
      { description: 'The Sword of a Thousand Truths', price: 1.2 },
      { description: 'Toilet Paper', price: 0.3 },
      { description: 'Torn Bed Sheet', price: 0.2 },
      { description: 'Torn Cloak Fragment', price: 0.3 },
      { description: 'Torn Condom', price: 0.06 },
      { description: 'Torn Underpants', price: 0.2 },
      { description: 'Toy Car', price: 0.15 },
      { description: 'Toy Horse', price: 0.25 },
      { description: 'Toy Truck', price: 0.2 },
      { description: 'Tuft of Fur', price: 0.15 },
      { description: 'Turd Sandwich Ballot', price: 0.15 },
      { description: 'USB Drive', price: 0.5 },
      { description: 'Urinal Deuce', price: 0.2 },
      { description: 'Used Firework', price: 0.15 },
      { description: 'Video Game', price: 0.8 },
      { description: 'Wad of Web', price: 0.1 },
      { description: 'Well-shined Boots', price: 0.3 },
      { description: 'VHS White Trash In Trouble VHS', price: 0.6 },
      { description: 'Wild Wacky Action Bike', price: 2.0 },
      { description: 'Wing CD', price: 0.4 }
    ]
  end

  def self.pan
    %w[
      2222405343248877 2222420000001113 2222990905257051 2223000048410010 2223007648726984 2223577120017656 3530111333300000 3566000020000410 3566002020360505 4001919257537193 4007702835532454
      4012888888881881 4111111111111111 4242420100058064 4263982640269299 4343430200036090 4622943127237569 4761360079851258 4917484589897107 5011054488597827 5019717010103742 5105105105105100
      5111010030175156 5185540810000019 5200533989557118 5200828282828210 5204230080000017 5204740009900014 5252520200034065 5353530200033106 5420923878724339 5425233430109903 5455330760000018
      5506900480000008 5506900490000436 5506900490000444 5506900510000234 5506920809243667 5506922400634930 5506927427317625 5553042241984105 5555553753048194 5555555555554444 5610591081018250
      5895626746595650 6011000990139424 6011000991300009 6011111111111117 6011556448578945 6034883265619896 6034932528973614 6062826786276634 6250941006528599 6271701225979642 6331101999990016
      6362970000457013
    ].sample
  end
end

class WebClient
  def self.user_agent
    [
      'Mozilla/5.0 (Windows NT 10.0; WOW64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.5788.202 Safari/537.36',
      'Mozilla/5.0 (Windows NT 10.0; WOW64; x64; rv:115.0esr) Gecko/20100101 Firefox/115.0esr',
      'Mozilla/5.0 (Windows NT 11.0; Win64; x64; rv:113.0esr) Gecko/20110101 Firefox/113.0esr',
      'Mozilla/5.0 (Windows NT 10.0.0; WOW64; Win64; x64; ) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.5938.92 Chrome/117.0.5938.92 Not;A=Brand/8  Safari/537.36',
      'Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36',
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:80.0) Gecko/20100101 Firefox/80.0',
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36',
      'Mozilla/5.0 (Linux; Android 11; Redmi Note 9 Pro) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Mobile Safari/537.36',
      'Mozilla/5.0 (Linux; Android 11; Redmi Note 9 Pro Build/RKQ1.200826.002; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/90.0.4430.210 Mobile Safari/537.36',
      'Mozilla/5.0 (Linux; Android 11; RMX1851) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.210 Mobile Safari/537.36',
      'Mozilla/5.0 (Linux; Android 11; RMX1851) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.73 Mobile Safari/537.36',
      'Mozilla/5.0 (Linux; Android 11; RMX1971) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Mobile Safari/537.36',
      'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/5.0)',
      'Mozilla/5.0 (iPhone; CPU iPhone OS 15_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.4 Mobile/15E148 Safari/604.1 (compatible; YandexMobileBot/3.0; +http://yandex.com/bots)',
      'Mozilla/5.0 (iPhone; CPU iPhone OS 15_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/100.0.4896.77 Mobile/15E148 Safari/604.1',
      'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/4.0; InfoPath.2; SV1; .NET CLR 2.0.50727; WOW64)',
      'Mozilla/5.0 (Android 12; Mobile; rv:109.0) Gecko/119.0 Firefox/119.0',
      'Mozilla/5.0 (Android 13.0.0; 2109119DG) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.5790.166 Chrome/115.0.5790.166 Not/A)Brand/99 Mobile Safari/537.36'
    ].sample
  end

  def self.build_payment(character, goods, cvv = rand(100..999).to_s)
    {
      'amount' => goods.sum { |g| g[:price] }.round(2),
      'items' => goods,
      'order_id' => Time.now.to_i.digits.reverse[3..].join + rand(1000..9999).to_s,
      'card' => {
        'pan' => SeedData.pan,
        'exp_date_month' => "0#{rand(1..9)}",
        'exp_date_year' => rand(23..29).to_s,
        'cardholder' => "#{character[:last_name]} #{character[:first_name]}".upcase,
        'cvv' => cvv
      }
    }
  end
end

class CheckerStatus
  def self.worked
    exit(101)
  end

  def self.corrupt
    exit(102)
  end

  def self.mumble
    exit(103)
  end

  def self.down
    exit(104)
  end
end

class ResourceChecker
  attr_reader :cvv, :url, :ip_address, :terminal_key

  BACK_PORT = 7000
  FRONT_PORT = 8080

  def initialize(flag:, ip_address:, flag_id: 'SouthParkBankTest')
    @ip_address = ip_address
    @url = "http://#{ip_address}:#{BACK_PORT}/"
    @cvv = flag
    @terminal_key = flag_id
  end

  def send_payment
    puts "[ SENDPAYMENT ] set payment to #{"http://#{ip_address}:#{BACK_PORT}/#{terminal_key}/payments"}"
    uri = URI("http://#{ip_address}:#{BACK_PORT}/#{terminal_key}/payments")
    req = Net::HTTP::Post.new(uri)
    req.content_type = 'application/json'
    req['accept'] = 'application/json'
    req.body = WebClient.build_payment(
      SeedData.characters.sample,
      SeedData.items.shuffle[0..rand(1..3)],
      cvv
    ).to_json
    puts "[ SENDPAYMENT ] payment data #{req.body}"
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end.body[14..-4] # сорян лень json парсить
  end

  def get_payment(token)
    puts "[ GET PAYMENT ] get by token #{token}"
    CheckerStatus.mumble unless Net::HTTP.get(URI("http://#{ip_address}:#{BACK_PORT}/#{terminal_key}/payments/#{token}")).include? cvv
  end

  def check?
    puts "[ CHECK       ] start"
    available?
    CheckerStatus.worked
  rescue StandardError => e
    puts "[ EXEPTIONS   ] #{e}"
    CheckerStatus.corrupt
  end

  def put?
    puts "[ PUT         ] start"
    available?
    token = send_payment
    puts "[ PUT         ] process"
    get_payment(token)
    puts "[ PUT         ] process"
    CheckerStatus.worked
  rescue StandardError => e
    puts "[ EXEPTIONS   ] #{e}"
    CheckerStatus.corrupt
  end

  private

  def available?
    puts "[ AVAILABLE   ] start"
    CheckerStatus.corrupt unless Net::HTTP.get(URI("http://#{ip_address}:#{FRONT_PORT}")).include? 'South Park Bank'
    puts "[ AVAILABLE   ] frontend work"
    CheckerStatus.corrupt unless Net::HTTP.get(URI("http://#{ip_address}:#{BACK_PORT}/version")).include? 'VERSION'
    puts "[ AVAILABLE   ] backend work"
  end
end

ip_address = ARGV[0] || '45.152.114.6' || '127.0.0.1'
command = ARGV[1] || 'check'
flag_id = ARGV[2] || 'SouthParkBankTest'
flag = ARGV[3] || SecureRandom.uuid
rc = ResourceChecker.new(flag_id: flag_id, flag: flag, ip_address: ip_address)
case command
when 'check'
  rc.check?
when 'put'
  rc.put?
end
