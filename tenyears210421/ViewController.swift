//
//  ViewController.swift
//  tenyears210421
//
//  Created by 陳諾 on 2021/4/21.
//

import UIKit

class ViewController: UIViewController {
    
    //設定outlet項目
    @IBOutlet weak var animeImage: UIImageView! //動畫介紹圖
    @IBOutlet weak var animeYear: UILabel! //動畫圖下方年份文字
    @IBOutlet weak var datePicker: UIDatePicker! //年曆日期選擇
    @IBOutlet weak var dateSlider: UISlider! //滑桿日期選擇
    @IBOutlet weak var autoPlay: UISwitch!
    
    let dateFormatter = DateFormatter() //設定日期的格式
    var imageNumber = 0
    var sliderNumber = 0
    
    let images = [2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020] //利用Array對應Assets內的動畫介紹圖名稱

    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "yyyy"
        // Do any additional setup after loading the view.
    }
        //利用switch與images的array取得對應的元件並抓取日期以文字呈現
        var dateString : String = ""
        func chooseImage(num1 : Int){
            switch num1 {
            case 0:
                dateString = "2010"
            case 1:
                dateString = "2011"
            case 2:
                dateString = "2012"
            case 3:
                dateString = "2013"
            case 4:
                dateString = "2014"
            case 5:
                dateString = "2015"
            case 6:
                dateString = "2016"
            case 7:
                dateString = "2017"
            case 8:
                dateString = "2018"
            case 9:
                dateString = "2019"
            case 10:
                dateString = "2020"
            default:
                dateString = "2010"
            }
            
            let date = dateFormatter.date(from: dateString)
            datePicker.date = date!
            
            let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: datePicker.date)
            let year = dateComponents.year!
            animeYear.text = "\(year)"
        }
    
    //啟動Timer
    var timer : Timer?
        func time () {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                self.compare()
            })
        }
        //利用if else比較陣列圖片，用於@IBAction func autoPlay
        func compare () {
            if imageNumber >= images.count {
                imageNumber = 0
                chooseImage(num1: imageNumber)
                animeImage.image = UIImage(named: String(images[imageNumber]))
            } else {
                chooseImage(num1: imageNumber)
                animeImage.image = UIImage(named: String(images[imageNumber]))
            }
            dateSlider.value = Float(imageNumber) //連動到slider
            imageNumber += 1
        }
    
    @IBAction func imageDatePicker(_ sender: UIDatePicker) {
        
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: datePicker.date) //取得datePicker的日期
        let year = dateComponents.year! //取得年份
        let imageName = "\(year)" //年份轉換為動畫介紹圖的名稱
        animeImage.image = UIImage(named: imageName) //設定動畫介紹圖抓取來源
        animeYear.text = "\(imageName)" //設定動畫介紹圖下方顯示之年份
        dateSlider.value = Float(year-2010) //將數值的變更連動到slider
        
        
    }
    
    @IBAction func imageDateSlider(_ sender: UISlider) {
       
        sliderNumber = Int(dateSlider.value) //取得slider數值
        sender.value.round() //將slider的數值四捨五入為整數
        animeYear.text = String(images[sliderNumber]) //設定動畫介紹圖下方顯示之年份
        animeImage.image = UIImage(named:String(images[sliderNumber])) //設定動畫介紹圖抓取來源
        let newDate = DateComponents(calendar: Calendar.current, year: images[sliderNumber]).date
                datePicker.date = newDate! //將數值的變更連動到datePicker
     
        }
    
    
    @IBAction func imageAutoPlay(_ sender: UISwitch) {
        if sender.isOn {
                    time()
                    imageNumber = sliderNumber
                    dateSlider.value = Float(imageNumber)
                } else {
                    timer?.invalidate()
                }

        }
    }


    

    



