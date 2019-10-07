//
//  DonateController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/18/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit

class RecycleController {
    
    static let shared = RecycleController()
    
    let user = UserController.shared.currentUser
    
    let hAndM = Recycle(storeName: "H&M", initiative: "Garment Collection Program \nAll textiles are welcome – any brand, any condition – even odd socks, worn-out T-shirts and old sheets.", logoImage: UIImage(named: "handm")!, webURL: "https://www2.hm.com/en_gb/ladies/shop-by-feature/16r-garment-collecting.html", category: .clothes)
    
    let theNorthFace = Recycle(storeName: "The North Face", initiative: "Clothes The Loop \nWe can help to ensure that worn clothes don’t end up in landfills.", logoImage: UIImage(named: "northface")!, webURL: "https://www.thenorthface.com/about-us/responsibility/product/clothes-the-loop.html", category: .clothes)
    
    let eileenFisher = Recycle(storeName: "Eileen Fisher", initiative: "Renew \nWhen you no longer wear your clothes, we take them back. Our Waste No More team transforms them into one-of-a-kind artworks, pillows and wall hangings using a custom felting method.", logoImage: UIImage(named: "eileenfisherlogo")!, webURL: "https://www.eileenfisherrenew.com/our-story", category: .clothes)
    
    let zara = Recycle(storeName: "Zara", initiative: "Collecting Clothes \nBring the clothes you no longer wear and give them a new life. As part of our social and enviornmental commitment we help you to easily extend the lifespan of your clothes.", logoImage: UIImage(named: "zara")!, webURL: "https://www.zara.com/us/en/sustainability-collection-program-l1452.html", category: .clothes)
    
    let oneWarmCoat = Recycle(storeName: "One Warm Coat", initiative: "Provide a free, warm coat to any person in need \nSupports individuals, groups, companies and organizations across the country by providing the tools and resources needed to hold a successful coat drive.", logoImage: UIImage(named: "oneWarmCoat")!, webURL: "https://www.onewarmcoat.org", category: .clothes)
    
    let levis = Recycle(storeName: "Levi Strauss & Co.", initiative: "Blue Jeans Go Green \n Recycled jeans can take on many new functions, but your denim will be used specifically as materials for building insulation, a portion of which will go towards community-oriented projects, such as libraries, hospitals and schools.", logoImage: UIImage(named: "levis")!, webURL: "https://www.levi.com/US/en_US/blog/article/where-to-recycle-your-clothes/" , category: .denim)
    
    let madeWell = Recycle(storeName: "Madewell", initiative: "Blue Jeans Go Green \nStop by one of our stores with your pre-loved pairs. Cotton’s Blue Jeans Go Green™ program will turn them into housing insulation for organizations like Habitat for Humanity", logoImage: UIImage(named: "madewell")!, webURL: "https://www.madewell.com/inspo-do-well-denim-recycling-landing.html", category: .denim)
    
    let cotton = Recycle(storeName: "Cotton", initiative: "Blue Jeans Go Green \nThe denim we collect is transformed into natural cotton fiber insulation, some of which is used to help with building efforts around the country", logoImage: UIImage(named: "cotton")!, webURL: "https://bluejeansgogreen.org/recycle-denim/", category: .denim)
    
    let americanEagle = Recycle(storeName: "American Eagle", initiative: "Blue Jeans Go Green \nHere’s an easy one… get rid of your old jeans. Seriously. Grab that pair that’s been taking up precious closet space for years. Whatever they are, wherever you got them from, we want them.", logoImage: UIImage(named: "ae")!, webURL: "http://blog.ae.com/2019/04/01/donate-your-old-jeans-take-10-off-your-new-favorite-pair/", category: .denim)
    
    let zappos = Recycle(storeName: "Zappos for Good", initiative: "Blue Jeans Go Green \nPack up your worn out denim, made from at least 90% cotton, in any shipping box you have around. You can send as many boxes as you like.", logoImage: UIImage(named: "zappos")!, webURL: "https://zapposforgood.org/recycle/bjgg", category: .denim)
    
    let nike = Recycle(storeName: "Nike", initiative: "Reuse-A-Shoe \nRecycles athletic shoes at the end of their life, giving them a new life through Nike Grind, and turns them into new places to play such as courts, tracks, fields and playgrounds.", logoImage: UIImage(named: "nike")!, webURL: "https://www.nike.com/us/en_us/c/better-world/reuse-a-shoe.%20", category: .shoes)
    
    let soles4Souls = Recycle(storeName: "Soles 4 Souls", initiative: "Wearing Out Poverty \nBelieves everyone around the world deserves a good pair of shoes. Creates sustainable jobs, provides relief through the distribution of shoes and clothing around the world, and disrupts the cycle of poverty.", logoImage: UIImage(named: "soles4souls")!, webURL: "https://soles4souls.org/gogreen/", category: .shoes)
    
    let dsw = Recycle(storeName: "DSW", initiative: "DSWGives + Soles 4 Souls \nDSW VIP members can donate shoes to those in need through Soles4Souls. Your donations help keep shoes out of land fills and create better opportunities for kids and families.", logoImage: UIImage(named: "dsw")!, webURL: "https://www.dsw.com/en/us/content/give-a-pair", category: .shoes)
    
    let zapposShoes = Recycle(storeName: "Zappos for Good", initiative: "The Remix Project, by Native Shoes \nNative Shoes will collect and recycle worn out Native Shoes and reprocess them into materials that can be used to build community playgrounds.", logoImage: UIImage(named: "zappos")!, webURL: "https://zapposforgood.org/recycle/native", category: .shoes)
    // for women
    let dressForSuccess = Recycle(storeName: "Dress For Success", initiative: "Going Places. Going Strong\nTo empower women to achieve economic independence by providing a network of support, professional attire and the development tools to help women thrive in work and in life.", logoImage: UIImage(named: "dressForSuccess")!, webURL: "https://dressforsuccess.org/get-involved/donation-drives/", category: .career)
    // men
    let careerGear = Recycle(storeName: "Career Gear", initiative: "A suit - a second chance. \nProvides professional clothing, mentoring and life-skills to help men in poverty become stronger contributors to their families and communities.", logoImage: UIImage(named: "careerGear")!, webURL: "https://careergear.org/get-involved/donate-clothing/", category: .career)
    
    let acdn = Recycle(storeName: "Alliance of Career Development NonProfits", initiative: "Assist individuals to secure and maintain employemnt \nDonate clothes to help job seekers dress for success - interview clothes, suits, and professional clothes are all welcome.", logoImage: UIImage(named: "acdn")!, webURL: "https://www.acdnonline.org/locations", category: .career)
    
    let braRecyclers = Recycle(storeName: "The Bra Recyclers", initiative: "Bra-volution \nFor women who have extra gently used bras in their drawers that could benefit women and girls in desperate need of a bra, The Bra Recyclers recycled over 4 million bras and support over 100 non-profit organizations.", logoImage: UIImage(named: "braRecyclers")!, webURL: "https://www.brarecycling.com/", category: .bras)
    
    let soma = Recycle(storeName: "Soma Boutique", initiative: "#BRAITFORWARD \nWomen in need at shelters rely on donated items to get back on their feet. When we heard bras were the most needed, yet least donated item of clothing, we had to help.", logoImage: UIImage(named: "somaintimates")!, webURL: "https://www.soma.com/store/page/soma+bra+donation/56709275/", category: .bras)
    
    let angelGown = Recycle(storeName: "Angel Gown", initiative: "NICU Helping Hands \nThe wedding gowns are converted into perfectly made garments that a family will use to wrap their precious baby in for their final journey.", logoImage: UIImage(named: "angelGowns")!, webURL: "https://www.nicuhelpinghands.org/programs/angel-gown-program/", category: .wedding)
    
    let bridesAcrossAmmerica = Recycle(storeName: "Brides Across America", initiative: "Committed to loving one another by gifting wedding gowns to military & first responders. To date we have gifted over 24,000 wedding dresses and over 22 free weddings.", logoImage: UIImage(named: "bridesAcrossAmerica")!, webURL: "https://www.bridesacrossamerica.com/giving/give-a-dress", category: .wedding)
    
    let beccasCloset = Recycle(storeName: "Becca's Closet", initiative: "Little Things Can Make A Big Difference \nBecca, a 16 year old caring young woman, passed away in a car accident on August 20, 2003. Her Freshman year Rebecca launched a dress drive to provide prom dresses and accessories to high school girls who could not afford them.", logoImage: UIImage(named: "beccasCloset")!, webURL: "https://www.beccascloset.org/beccas-closet-chapters/", category: .prom
)
    
    func loadContent() -> [[Recycle]] {
        guard let user = user else {
            
            // clothes, denim, clothes & shoes, shoes, career, bras, wedding gowns, prom dresses, default
            
            return [[hAndM, theNorthFace, eileenFisher, zara, oneWarmCoat], [levis, madeWell, cotton, americanEagle, zappos], [nike, soles4Souls, dsw, zapposShoes], [dressForSuccess, careerGear, acdn], [braRecyclers, soma], [angelGown, bridesAcrossAmmerica], [beccasCloset]] }
        if user.isMale == true {
            return [[hAndM, theNorthFace, oneWarmCoat], [levis, madeWell, cotton, americanEagle, zappos], [nike, soles4Souls, dsw, zapposShoes], [careerGear, acdn]]
        } else {
            return [[hAndM, theNorthFace, oneWarmCoat, eileenFisher, zara], [levis, madeWell, cotton, americanEagle, zappos], [nike, soles4Souls, dsw, zapposShoes], [dressForSuccess, acdn], [braRecyclers, soma], [angelGown, bridesAcrossAmmerica], [beccasCloset]]
        }
    }
    
    var recyclePlaces: [Recycle] = []
}
