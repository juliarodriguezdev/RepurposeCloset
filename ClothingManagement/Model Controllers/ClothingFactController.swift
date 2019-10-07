//
//  ClothingFactController.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/20/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import Foundation

class ClothingFactController {
    
    static let shared = ClothingFactController()
    
    var clothingFacts: [ClothingFact] = []
    
    // instance
    
    // \"
    let f1 = ClothingFact(fact: "It takes 700 gallons of water to make a cotton shirt", source: "\n\n- Planetaid.org", type: .water)
    
    let f2 = ClothingFact(fact: "Every year, more than 80 billion articles of clothing are produced and sold around the world.", source: "\n\n- Planetaid.org", type: .clothing)
    
    let f3 = ClothingFact(fact: "...the amount of water needed to make a t-shirt is enough for 1 person to stay hydrated for 900 days while the amount of water needed to make a pair of jeans is equivalent to hosing down your lawn for 9 hours straight.", source: "\n\n- Planetaid.org", type: .water)
    
    let f4 = ClothingFact(fact: "The average American throws out about 82 pounds of textile waste per year. That’s 11 million tons of waste produced every year by just the United States alone. ", source: "\n\n- Planetaid.org", type: .landfill)
    
    let f5 = ClothingFact(fact: "Clothes can take up to 40 years to decompose.", source: "\n\n- Planetaid.org", type: .landfill)
    
    let f6 = ClothingFact(fact: "In addition to releasing gases like methane, most fabrics are made with dyes and chemicals that can contaminate the soil and water in the ground. ", source: "\n\n- Planetaid.org", type: .dyes)
    
    let f7 = ClothingFact(fact: "Shoes can take up to 1,000 years to break down.", source: "\n\n- Planetaid.org", type: .landfill)
    
    let f8 = ClothingFact(fact: "Commonly made with a material called ethylene vinyl, the midsoles of shoes can take a really long time to break down.", source: "\n\n- Planetaid.org", type: .landfill)
    
    let f9 = ClothingFact(fact: "95% of textiles can be recycled. This means that there is an alternative to landfill waste.", source: "\n\n- Planetaid.org", type: .landfill)
    
    let f10 = ClothingFact(fact: "Textiles can be repurposed into a number of things, including sports fields, pillow stuffing, and paper money. ", source: "\n\n- Planetaid.org", type: .playfields)
    
    let f11 = ClothingFact(fact: "Whether the textile fibers are turned into carpet padding, baseball filling or jewelry box lining, you never know where your recycled clothes might end up!", source: "\n\n- Planetaid.org", type: .cotton)
    
    let f12 = ClothingFact(fact: "70% of the world wears secondhand clothing.", source: "\n\n- Planetaid.org", type: .secondHand)
    
    let f13 = ClothingFact(fact: "The Environmental Protection Agency estimates that the average person throws away 81 pounds of clothing per year.    That adds up to 3.8 billion pounds of unnecessary waste added to our landfills.", source: "\n\n- Smartasn.org", type: .landfill)
    
    let f14 = ClothingFact(fact: "Recycling clothing and textiles decreases the use of natural resources, such as water used in growing crops an petroleum used in creating new clothing and textiles.", source: "\n\n- Smartasn.org", type: .recycle)
    
    let f15 = ClothingFact(fact: "Since the mid 1940’s U.S. charities and the post-consumer textile recycling industry have repurposed and recycled billions of pounds of clothing, household textiles, shoes, and accessories.", source: "\n\n-Council for Textile Recycling", type: .recycle)
    
    let f16 = ClothingFact(fact: "Nearly 70 million barrels of oil are used each year to make the world’s polyester fiber, which is now the most commonly used fiber in our clothing. But it takes more than 200 years to decompose.", source: "\n\n- Forbes.com", type: .oil)
    
    let f17 = ClothingFact(fact: "More than 150 billion garments are produced annually, enough to provide 20 new garments to every person on the planet, every year.", source: "\n\n- Forbes.com", type: .clothing)
    
    let f18 = ClothingFact(fact: "Fast fashion garments, which we wear less than 5 time and keep for 35 days, produce over 400% more carbon emissions per item per year than garments worn 50 times and kept for a full year.", source: "\n\n- Forbes.com", type: .pollution)
    
    let f19 = ClothingFact(fact: "Cheap synthetic fibers also emit gasses like N2O, which is 300 times more damaging than CO2.", source: "\n\n- Forbes.com", type: .pollution)
    
    let f20 = ClothingFact(fact: "Over 70 million trees are logged every year and turned into fabrics like rayon, viscose, modal and lyocell.", source: "\n\n- Forbes.com", type: .clothing)
    
    let f21 = ClothingFact(fact: "Cotton is the world’s single largest pesticide-consuming crop, using 24% of all insecticides and 11% of all pesticides globally, adversely affecting soil and water.", source: "\n\n- Forbes.com", type: .cotton)
    
    let f22 = ClothingFact(fact: "Plastic microfibers shed from our synthetic clothing into the water supply account for 85% of the human-made material found along ocean shores, threatening marine wildlife and ending up in our food supply.", source: "\n\n- Forbes.com", type: .water)
    
    let f23 = ClothingFact(fact: "The fashion industry is the second biggest polluter of freshwater resources on the planet.", source: "\n\n- Forbes.com", type: .water)
    
    let f24 = ClothingFact(fact: "The apparel industry accounts for 10% of global carbon emissions and remains the second largest industrial polluter, second only to oil.", source: "\n\n- Forbes.com", type: .pollution)
    
    let f25 = ClothingFact(fact: "More than 15 million tons of used textile waste is generated each year in the United States, and the amount has doubled over the last 20 years.", source: "\n\n- Thebalancesmb.com", type: .landfill)
    
//    let f26 = ClothingFact(fact: "Consumers are regarded as the main culprit for throwing away their used clothing, as only 15 percent of consumer-used clothing is recycled, whereas more than 75 percent of pre-use clothing is recycled by the manufacturers.", source: "\n\n- Thebalancesmb.com", type: .recycle)
    
    let f27 = ClothingFact(fact: "The average person buys 60% more items of clothing every year and keeps them for about half as long as 15 years ago, generating a huge amount of waste. ", source: "\n\n- Thebalancesmb.com", type: .clothing)
    
    let f28 = ClothingFact(fact: "The annual environmental impact of a household’s clothing is equivalent to the water needed to fill 1,000 bathtubs and the carbon emissions from driving an average modern car for 6,000 miles", source: "\n\n- Thebalancesmb.com", type: .water)
    
    let f29 = ClothingFact(fact: "If the average life of clothing was extended by just three months, it would reduce their carbon and water footprints, as well as waste generation, by 5 to 10 percent.", source: "\n\n- Thebalancesmb.com", type: .recycle)
    
    let f30 = ClothingFact(fact: "About 50% of collected shoes and clothing is used as secondhand products. Meanwhile, 20% is used to produce polishing and cleaning cloths for various industrial purposes, and 26% is recycled for applications such as fiber for insulation products, upholstery, fiberboard, and mattresses.", source: "\n\n- Thebalancesmb.com", type: .secondHand)
    
    let f31 = ClothingFact(fact: "The United States textile recycling industry removes approximately 2.5 billion pounds of post-consumer textiles each year from the waste stream, and the industry creates more than 17,000 jobs.", source: "\n\n- Thebalancesmb.com", type: .secondHand)
    
    let f32 = ClothingFact(fact: "Meanwhile, synthetic fibers, like polyester, nylon and acrylic, have the same environmental drawbacks, and because they are essentially a type of plastic made from petroleum, they will take hundreds of years, if not a thousand, to biodegrade.", source: "\n\n- Newsweek.com", type: .pollution)
    
    let f33 = ClothingFact(fact: "It can take up to 200 tons of fresh water per ton of dyed fabric.  ", source: "\n\n- Sustainyourstyle.org", type: .water)
    
    let f34 = ClothingFact(fact: "Up to 20,000 liters of water are needed to produce just 1kg of cotton.", source: "\n\n- Sustainyourstyle.org", type: .water)
    
    let f35 = ClothingFact(fact: "In most of the countries in which garments are produced, untreated toxic wastewaters from textiles factories are dumped directly into the rivers.", source: "\n\n- Sustainyourstyle.org", type: .water)
    
    let f36 = ClothingFact(fact: "Wastewater contains toxic substances such as lead, mercury, and arsenic, among others. These are extremely harmful for the aquatic life and the health of the millions people living by those rivers banks. The contamination also reaches the sea and eventually spreads around the globe. ", source: "\n\n- Sustainyourstyle.org", type: .water)
    
    let f37 = ClothingFact(fact: "20% of industrial water pollution comes form textiles treatment and dying", source: "\n\n- Sustainyourstyle.org", type: .dyes)
    
    let f38 = ClothingFact(fact: "20,000 tons of dyes are lost to effluents every year.", source: "\n\n- Sustainyourstyle.org", type: .dyes)
    
    let f39 = ClothingFact(fact: "90% of wastewaters in developing countries is discharged into rivers without treatment", source: "\n\n- Sustainyourstyle.org", type: .water)
    
    let f40 = ClothingFact(fact: "The fashion industry is a major water consumer.Huge quantity of fresh water are used for the dyeing and finishing process for all of our clothes.", source: "\n\n- Sustainyourstyle.org", type: .water)
    
    let f41 = ClothingFact(fact: "200 tons of fresh water are needed to dye one ton of fabric", source: "\n\n- Sustainyourstyle.org", type: .dyes)
    
    let f42 = ClothingFact(fact: "Every time we wash a synthetic garment (polyester,nylon, etc), about 1,900 individual microfibers are released into the water, making their way into our oceans.", source: "\n\n- Sustainyourstyle.org", type: .water)
    
    let f43 = ClothingFact(fact: "Scientists have discovered that small aquatic organisms ingest those microfibers. These are then eaten by small fish which are later eaten by bigger fish, introducing plastic in our food chain.", source: "\n\n- Sustainyourstyle.org", type: .water)
    
    let f44 = ClothingFact(fact: "85% of human-made debris on the shorelines around the world are microfibers", source: "\n\n- Sustainyourstyle.org", type: .water)
    
    let f45 = ClothingFact(fact: "190,000 tons of textile microplastic fibers end up in the oceans every year", source: "\n\n- Sustainyourstyle.org", type: .water)
    // add
    let f46 = ClothingFact(fact: "There are more than 500 garment-recycling companies in the U.S. and a majority of these companies are owned and operated by small and family businesses, each of which employs 35 to 50 workers.", source: "\n\n- Thebalancesmb.com", type: .secondHand)
    
    let f47 = ClothingFact(fact: "Synthetic fibers, such as polyester, are plastic fibers, therefore non-biodegradable and can take up to 200 years to decompose. Synthetic fibers are used in 72% of our clothing.", source: "\n\n- Sustainyourstyle.org", type: .landfill)
    
    let f48 = ClothingFact(fact: "3 years is the average liftime of a garment today", source: "\n\n- Sustainyourstyle.org", type: .clothing)
    
    let f49 = ClothingFact(fact: "The heavy use of chemicals in cotton farming is causing diseases and premature death among cotton farmers, along with massive freshwater and ocean water pollution and soil degradation.", source: "\n\n- Sustainyourstyle.org", type: .cotton)
    
    let f50 = ClothingFact(fact: "1 Kg of chemicals is needed to produce 1 Kg of textiles", source: "\n\n- Sustainyourstyle.org", type: .pollution)
    
    let f51 = ClothingFact(fact: "23% of all chemicals produced worldwide are used for the textile industry", source: "\n\n- Sustainyourstyle.org", type: .pollution)
    
    let f52 = ClothingFact(fact: "27% of the weight of a \"100% natural\" fabric is made of chemicals", source: "\n\n- Sustainyourstyle.org", type: .pollution)
    
    let f53 = ClothingFact(fact: "Synthetic fibers (polyester, acrylic, nylon, etc.), used in the majority of our clothes, are made from fossil fuel, making production much more energy-intensive than with natural fibers.", source: "\n\n- Sustainyourstyle.org", type: .pollution)
    
    let f54 = ClothingFact(fact: "Most of our clothes are produced in China, Bangladesh, or India, countries essentially powered by coal. This is the dirtiest type of energy in terms of carbon emissions.", source: "\n\n- Sustainyourstyle.org", type: .pollution)
    
    let f55 = ClothingFact(fact: "Cheap synthetic fibers also emit gases like N2O, which is 300 times more damaging than CO2.", source: "\n\n- Forbes.com", type: .pollution)
    
    let f56 = ClothingFact(fact: "23 kG of greenhouse gases are generated for each kilo of fabric produced", source: "\n\n- Sustainyourstyle.org", type: .pollution)
    
    let f57 = ClothingFact(fact: "70 million oil barrels are used each year to produce polyester", source: "\n\n- Sustainyourstyle.org", type: .oil)
    
    let f58 = ClothingFact(fact: "400% more carbon emissions are produced if we wear a garment 5 times instead of 50 times", source: "\n\n- Sustainyourstyle.org", type: .pollution)

    let f60 = ClothingFact(fact: "70 millions trees are cut down each year to make our clothes", source: "\n\n- Sustainyourstyle.org", type: .trees)
    
    let f61 = ClothingFact(fact: "30% of rayn and viscose clothing comes from endangered and ancient forests", source: "\n\n- Sustainyourstyle.org", type: .trees)
    
    let f62 = ClothingFact(fact: "5% of the global apparel industry uses forest based products", source: "\n\n- Sustainyourstyle.org", type: .trees)
    
    let f63 = ClothingFact(fact: "According to a World Bank estimate, almost 20% of global industrial water pollution comes from the treatment and dyeing of textiles.", source: "\n\n- Fabricoftheworld.com", type: .dyes)
    
    let f64 = ClothingFact(fact: "About 72 toxic chemicals reach our water supply from textile dyeing, many of which cannot be filtered or removed.", source: "\n\n- Fabricoftheworld.com", type: .water)
    
    let f65 = ClothingFact(fact: "Wastewater discharged by the textile industry contains chemicals such as formaldehyde (HCHO), chlorine and heavy metals such as lead and mercury.", source: "\n\n- Fabricoftheworld.com", type: .water)
    
    let f66 = ClothingFact(fact: "Landfills contain minimal amounts of oxygen and moisture, so they are not designed to breakdown trash, but to bury it.", source: "\n\n- Fabricoftheworld.com", type: .landfill)
    
    let f67 = ClothingFact(fact: "In North America alone, consumers are buying and discarding five times as much clothing as they did 25 years ago. About 85% of this ends up in landfills.", source: "\n\n- Fabricoftheworld.com", type: .landfill)
    
    let f68 = ClothingFact(fact: "Textile waste forms leachate as it decomposes, often contaminating groundwater through leakage.", source: "\n\n- Fabricoftheworld.com", type: .water)
    
    let f69 = ClothingFact(fact: "The decomposition of organic fibres and yarn such as wool produces large amounts of ammonia and methane. Ammonia is highly toxic in both terrestrial and aquatic environments, and can be toxic in gaseous form.", source: "\n\n- Fabricoftheworld.com", type: .pollution)
    
    let f70 = ClothingFact(fact: "...in landfills where textile waste is incinerated in large quantities, harmful substances such as dioxins, heavy metals, acidic gases and dust particles are emitted.", source: "\n\n- Fabricoftheworld.com", type: .landfill)
    
    let f71 = ClothingFact(fact: "Today, more than 70% of the world’s population uses second-hand clothing.", source: "\n\n- Fabricoftheworld.com", type: .secondHand)
    
    let f72 = ClothingFact(fact: "While natural cotton fibre is completely biodegradable, it can take over 20,000 litres of water to produce cotton for a single T-shirt and pair of jeans. ", source: "\n\n- Fabricoftheworld.com", type: .cotton)
    
    let f73 = ClothingFact(fact: "...polyester fibre is made from petroleum, a non-renewable resource that creates damaging environmental impacts during the extraction process.", source: "\n\n- Fabricoftheworld.com", type: .pollution)
    
    let f74 = ClothingFact(fact: "Globally, 80% of discarded textiles are doomed for the landfill or incineration. Only 20% are actually reused or recycled.", source: "\n\n- Remake.world", type: .landfill)
    
    let f75 = ClothingFact(fact: "The clothing that ends up in landfills can sit there for 200-plus years, and as it decomposes, it emits methane—a greenhouse gas more potent than carbon.", source: "\n\n- Remake.world", type: .landfill)
    
    let f77 = ClothingFact(fact: "Goods that were not recycled or reused translate into about an $88 billion loss. That’s due to a loss in value and resources that went into making them.", source: "\n\n- HuffPost.com", type: .landfill)
    
    let f78 = ClothingFact(fact: "...contributing to the secondhand industry, helps to infuse money into the economy. The industry employs nearly 100,000 workers and creates $1 billion in wages in the U.S. alone.", source: "\n\n- HuffPost.com", type: .secondHand)
    
    func loadClothingFacts() {
        clothingFacts = [f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37, f38, f39, f40, f41, f42, f43, f44, f45, f46, f47, f48, f49, f50, f51, f52, f53, f54, f55, f56, f57, f58, f60, f61, f62, f63, f64, f65, f66, f67, f68, f69, f70, f71, f72, f73, f74, f75, f77, f78]
    }
    
}
