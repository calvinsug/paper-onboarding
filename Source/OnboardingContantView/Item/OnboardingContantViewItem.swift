//
//  OnboardingContentViewItem.swift
//  AnimatedPageView
//
//  Created by Alex K. on 21/04/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

 open class OnboardingContentViewItem: UIView {
  
  var bottomConstraint: NSLayoutConstraint?
  var centerConstraint: NSLayoutConstraint?
  
  open var imageView: UIImageView?
  open var movieController: AVPlayerViewController?
  open var movieView: UIView?
  open var titleLabel: UILabel?
  open var descriptionLabel: UILabel?
  open var index: Int?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: public

extension OnboardingContentViewItem {
  
  class func itemOnView(_ view: UIView) -> OnboardingContentViewItem {
    let item = Init(OnboardingContentViewItem(frame:CGRect.zero)) {
      $0.backgroundColor                           = .clear
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    view.addSubview(item)
    // add constraints
    item >>>- {
      $0.attribute = .height
      $0.constant  = 10000
      $0.relation  = .lessThanOrEqual
      return
    }

    for attribute in [NSLayoutAttribute.leading, NSLayoutAttribute.trailing] {
      (view, item) >>>- {
        $0.attribute = attribute
        return
      }
    }
    
    for attribute in [NSLayoutAttribute.centerX, NSLayoutAttribute.centerY] {
      (view, item) >>>- {
        $0.attribute = attribute
        return
      }
    }
    
   return item
  }
}

// MARK: create

private extension OnboardingContentViewItem {
  
  func commonInit() {
    let titleLabel       = createTitleLabel(self)
    let descriptionLabel = createDescriptionLabel(self)
    let imageView        = createImage(self)
    let movieView        = createMovieView(self)

    // added constraints
    centerConstraint = (self, titleLabel, imageView) >>>- {
      $0.attribute       = .top
      $0.secondAttribute = .bottom
      $0.constant        = 50
      return
    }
    
    (self, descriptionLabel, titleLabel) >>>- {
      $0.attribute       = .top
      $0.secondAttribute = .bottom
      $0.constant        = 40
      return
    }

    self.titleLabel       = titleLabel
    self.descriptionLabel = descriptionLabel
    self.imageView        = imageView
    self.movieView        = movieView
    self.movieController  = createMovieController()
  }

  func createTitleLabel(_ onView: UIView) -> UILabel {
    let label = Init(createLabel()) {
      $0.font = UIFont(name: "Nunito-Bold" , size: 36)
    }
    onView.addSubview(label)
    
   // add constraints
    label >>>- {
      $0.attribute = .height
      $0.constant  = 10000
      $0.relation  = .lessThanOrEqual
      return
    }

    for attribute in [NSLayoutAttribute.centerX, NSLayoutAttribute.leading, NSLayoutAttribute.trailing] {
      (onView, label) >>>- {
        $0.attribute = attribute
        return
      }
    }
    return label
  }
  
  func createDescriptionLabel(_ onView: UIView) -> UILabel {
    let label = Init(createLabel()) {
      $0.font          = UIFont(name: "OpenSans-Regular" , size: 14)
      $0.numberOfLines = 0
    }
    onView.addSubview(label)
    
    // add constraints
    label >>>- {
      $0.attribute = .height
      $0.constant  = 10000
      $0.relation  = .lessThanOrEqual
      return
    }

    for (attribute, constant) in [(NSLayoutAttribute.leading, 30), (NSLayoutAttribute.trailing, -30)] {
      (onView, label) >>>- {
        $0.attribute = attribute
        $0.constant  = CGFloat(constant)
        return
      }
    }

    (onView, label) >>>- { $0.attribute = .centerX; return }
    bottomConstraint = (onView, label) >>>- { $0.attribute = .bottom; return }

    return label
  }

  func createLabel() -> UILabel {
    return Init(UILabel(frame: CGRect.zero)) {
      $0.backgroundColor                           = .clear
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.textAlignment                             = .center
      $0.textColor                                 = .white
    }
  }

  func createImage(_ onView: UIView) -> UIImageView {
    let imageView = Init(UIImageView(frame: CGRect.zero)) {
      $0.contentMode                               = .scaleAspectFill
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    onView.addSubview(imageView)
    
    // add constraints
    for attribute in [NSLayoutAttribute.width, NSLayoutAttribute.height] {
      imageView >>>- {
        $0.attribute = attribute
        $0.constant  = 130
        return
      }
    }
    
    for (attribute, constant) in [(NSLayoutAttribute.centerX, 0), (NSLayoutAttribute.top, 33)] {
      (onView, imageView) >>>- {
        $0.attribute = attribute;
        $0.constant = CGFloat(constant)
        return
      }
    }
    
    return imageView
  }

  func createMovieView(_ onView: UIView) -> UIView {
    let movieView = Init(UIView(frame: CGRect(x: 0, y: 0, width: 114, height: 198))) {
        $0.backgroundColor = .blue
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = true
    }
    
    onView.addSubview(movieView)
    
    for (attribute, constant) in [(NSLayoutAttribute.width, 114), (NSLayoutAttribute.height, 198)] {
        movieView >>>- {
            $0.attribute = attribute
            $0.constant  = CGFloat(constant)
            return
        }
    }
    
    for (attribute, constant) in [(NSLayoutAttribute.centerX, 0), (NSLayoutAttribute.top, 0)] {
        (onView, movieView) >>>- {
            $0.attribute = attribute;
            $0.constant = CGFloat(constant)
            return
        }
    }
    
    return movieView
  }
    
  func createMovieController() -> AVPlayerViewController {
    let movieController = Init(AVPlayerViewController()) {
        $0.showsPlaybackControls = false
        $0.view.frame = CGRect(x: 0, y: 0, width: 114, height: 198)
    }
    
    movieView?.addSubview(movieController.view)
    
    return movieController
  }
    
}
