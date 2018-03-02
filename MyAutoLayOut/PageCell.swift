
import UIKit

class PageCell: UICollectionViewCell {
    //컨트롤에서 넘겨줄 모델 데이터 받을 변수
    var page: Page? {
        didSet {
            print("PageCell didSet 진입")
            //언래핑:널값을 안전하게 처리하기 위해서 언래핑 해준다.
            guard let unwrappedPage = page else { return }
            //위에서 언래핑한 객체모델.변수 이름으로 데이터 view에 뿌려주기
            do {
             let url = URL(string: unwrappedPage.imageName)
             let data = try Data(contentsOf: url!)
            
             myImageView.image = UIImage(data: data)
             }
             catch{
             print(error)
             }
            
            //myImageView.image = UIImage(named: unwrappedPage.imageName)
            //마찬가지
            let attributedText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
            
            attributedText.append(NSAttributedString(string: "\n\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.gray]))
            
            myTextView.attributedText = attributedText
            myTextView.textAlignment = .center
        }
    }
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
       // let attributedText = NSMutableAttributedString(string: "ios기초 레슨 프로그램", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
        
        //attributedText.append(NSAttributedString(string: "\n\n\n 할아0버지 할머니도, 엄마도 아빠도 쉽게 배울 수 있는 아이폰 개발 강좌~!! 모두 열공 가즈아~~~~!", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        
        //textView.attributedText = attributedText
        
        //textView.text = "ios기초 레슨 프로그램"
        //textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.translatesAutoresizingMaskIntoConstraints = false
        //textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()

    //부모 인스턴스를 초기화 해줘야 커스터마이징 해줄 수 있다.
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
        
        let containerView = UIView()
        containerView.backgroundColor = .yellow
        //현재 cell에 콘테이너 뷰 추가
        addSubview(containerView)
        // 오토레이아웃 활성화
        //이제 제약조건이 view 기준이 아니기 때문에 view를 빼줘야 한다.
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        //부모뷰에 이미지 뷰 넣어주기
        containerView.addSubview(myImageView)
        
        
        myImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        myImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        myImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5).isActive = true
        
        //부모뷰의 높이를 view의 절반으로 맞춰줬다.
        containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
        //현재 cell에 textview 추가
        addSubview(myTextView)
        //myTextView의  topAnchor를 이미지뷰 아래에 맟추고 120 만큼 간격 띄어주기
        //이제 제약조건이 view 기준이 아니기 때문에 view를 빼줘야 한다.
        myTextView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 30).isActive = true
        myTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        myTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        myTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

