
import UIKit
extension UIColor {
    static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
}

class ViewController: UIViewController {
    
    //클로저 기능으로 이미지객체 만들어주기(내부에서 속성정의)
    let myImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "mypic1"))
        // 이속성은 autolayout을 이용할 수 있게한다.
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    ////클로저 기능으로 textView객체 만들어주기(내부에서 속성정의)
    let myTextView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "ios기초 레슨 프로그램", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
        
        attributedText.append(NSAttributedString(string: "\n\n\n 할아버지 할머니도, 엄마도 아빠도 쉽게 배울 수 있는 아이폰 개발 강좌~!! 모두 열공 가즈아~~~~!", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        
        textView.attributedText = attributedText
        
        //textView.text = "ios기초 레슨 프로그램"
        //textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    //이전 버튼
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("이전", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    //다음 버튼
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("다음", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.mainPink, for: .normal)
        return button
    }()
    //페이지 컨트롤러
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // view에 위에서 만든 객체뷰를 넣어준다.
        //view.addSubview(myImageView)
        view.addSubview(myTextView)
        
        //위에서 만든 객체뷰 autolayout 정해주기
        setupLayout()
        // 스택뷰 관련 함수 호출
        setupBottomControls()
    }
    
    //스택뷰 객세 생성과 위치 설정 함수
    fileprivate func setupBottomControls() {
        
        //uistackview 객체 만들기 배열 타입으로 view 객체들이 들어간다
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        //오토레이아웃 설정 허용해주기
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        //객체들이 하나하나 보이게 설정
        bottomControlsStackView.distribution = .fillEqually
        //bottomControlsStackView.axis = .vertical
        
        //전체 뷰에 위에서 만든 stackView를 넣어준다.
        view.addSubview(bottomControlsStackView)
        
        //스택뷰 위치 지정해주기
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    private func setupLayout() {
        
        let containerView = UIView()
        containerView.backgroundColor = .yellow
        view.addSubview(containerView)
        // 오토레이아웃 활성화
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        //부모뷰에 이미지 뷰 넣어주기
        containerView.addSubview(myImageView)
        
        
        myImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        myImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        myImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5).isActive = true
        
        //부모뷰의 높이를 view의 절반으로 맞춰줬다.
        containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        
        //myTextView의  topAnchor를 이미지뷰 아래에 맟추고 120 만큼 간격 띄어주기
        myTextView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 120).isActive = true
        myTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        myTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        myTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
}











