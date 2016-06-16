//
//  ViewController.swift
//  demo_swift
//
//  Created by 张超 on 16/6/16.
//  Copyright © 2016年 orzer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let buttonMenu = XXXRoundMenuButton();
        self.view.addSubview(buttonMenu);
        buttonMenu.frame = CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2-100, 200, 200);
        buttonMenu.centerButtonSize = CGSizeMake(44, 44);
        buttonMenu.tintColor = UIColor.whiteColor();
        buttonMenu.jumpOutButtonOnebyOne = true;
        
        
        
        buttonMenu.loadButtonWithIcons([UIImage(named: "icon_can")!,UIImage(named: "icon_pos")!,UIImage(named: "icon_img")!], startDegree: -M_PI, layoutDegree: M_PI/2);
        
        buttonMenu.buttonClickBlock =  {(idx:NSInteger)-> Void in
            NSLog("%d", idx);
        };
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

