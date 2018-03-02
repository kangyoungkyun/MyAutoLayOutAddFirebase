
import UIKit
import Firebase
//UICollectionViewController를 상속 받는 클래스, 레이아웃과 cell의 size를 조정하려면 UICollectionViewDelegateFlowLayout을
//상속받아야 한다.
class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
        var ref: DatabaseReference!
        var pages : Array<Page> = Array<Page>()
    
    //이전 버튼
    private let preButton :UIButton = {
        let preBtn = UIButton(type:.system)
        preBtn.setTitle("이전", for: .normal)
        preBtn.translatesAutoresizingMaskIntoConstraints = false
        preBtn.setTitleColor(.gray, for: .normal)
        preBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        preBtn.addTarget(self, action: #selector(handlePre), for: .touchUpInside)
        return preBtn
        
    }()
    @objc func handlePre(){
        print("이전")
        //print(pageControl.currentPage+1)//1
        //print(pages.count-1)//2
        
        let nextIndex = max(pageControl.currentPage - 1, 0) //1
        let indexPath = IndexPath(item: nextIndex, section: 0) //[0,1]
        print("next index = \(nextIndex)")
        print("indexPath = \(indexPath)")
        pageControl.currentPage = nextIndex //1
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        //print(nextIndex)
    }
    
    //다음 버튼
    private let nextButton :UIButton = {
        let nxtBtn = UIButton(type:.system)
        nxtBtn.setTitle("다음", for: .normal)
        nxtBtn.translatesAutoresizingMaskIntoConstraints = false
        nxtBtn.setTitleColor(.mainPink, for: .normal)
        nxtBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        nxtBtn.addTarget(self, action: #selector(handeNext), for: .touchUpInside) //터치가 이루어졌을때 handeNext 함수 호출
        return nxtBtn
    }()
    
    @objc func handeNext(){
        print("next")
        //print(pageControl.currentPage+1)//1
        //print(pages.count-1)//2
        //다음페이지 번호 구하기 - min 제일 작은값을 가져온다. 참고로 currentPage는 0 인 상태다
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1) //1
        let indexPath = IndexPath(item: nextIndex, section: 0) //[0,1]
        print("next index = \(nextIndex)")
        print("indexPath = \(indexPath)")
        pageControl.currentPage = nextIndex //1
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        //print(nextIndex)
    }
    
    //페이지 컨트롤러
     lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.currentPage = 0
        //let a = pages.count
        //pc.numberOfPages = 3
        //print("페이지 컨트롤러 개수는? \(pc.numberOfPages)")
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()

    //오른쪽으로 스크롤 했을 때 - 위치로 현재 페이지 구해주기
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad 진입")
         callFirebase()
        //DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {

        //}
        // 스택뷰 관련 함수 호출
        self.setupBottomControls()
        //배경색을 흰색
        self.collectionView?.backgroundColor = .white
        //collectionView에 cell을 등록해주는 작업, 여기서는 직접 만든 cell을 넣어주었고, 아이디를 설정해 주었다.
        self.collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        //페이징기능 허용
        self.collectionView?.isPagingEnabled = true

        //ref.removeObserver(withHandle: 0)
        
    }

    //스택뷰 객세 생성과 위치 설정 함수
    fileprivate func setupBottomControls() {
        print("setupBottomControls 진입")
        //uistackview 객체 만들기 배열 타입으로 view 객체들이 들어간다
        let bottomControlsStackView = UIStackView(arrangedSubviews: [preButton, pageControl, nextButton])
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
    
    
    
    private func callFirebase(){
        ref = Database.database().reference()
               
        
        //let scoresRef = Database.database().reference()
        //ref.keepSynced(true)
        print("callFirebase 진입")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            
           
            
            if(snapshot.exists()){
                let value = snapshot.value as? NSDictionary
                let koValue = value?["ko"] as? NSDictionary
                let enValue = value?["en"] as? NSDictionary
                let lastValue = value?["last"] as? NSDictionary
                
                let url = koValue!["url"] as? String ?? ""
                let body = koValue?["body"] as? String ?? ""
                let head = koValue?["head"] as? String ?? ""
                
                
                //print(url,body,head)
                let user = Page(imageName: url, headerText: head, bodyText: body)
                self.pages.append(user)
                
                let enurl = enValue!["url"] as? String ?? ""
                let enbody = enValue?["body"] as? String ?? ""
                let enhead = enValue?["head"] as? String ?? ""
                //print(enurl,enbody,enhead)
                let enuser = Page(imageName: enurl, headerText: enhead, bodyText: enbody)
                self.pages.append(enuser)
                
                let lasturl = lastValue!["url"] as? String ?? ""
                let lastbody = lastValue?["body"] as? String ?? ""
                let lasthead = lastValue?["head"] as? String ?? ""
                //print(lasturl,lastbody,lasthead)
                let lastuser = Page(imageName: lasturl, headerText: lasthead, bodyText: lastbody)
                self.pages.append(lastuser)
                print("callFirebase 끝1")
                
            }

            //페이지 컨트롤러 페이지 개수 할당해주기
            self.pageControl.numberOfPages = self.pages.count
            
            
            DispatchQueue.main.async(execute: {
                 print("callFirebase 끝2")
                self.collectionView?.reloadData()
            })
        }, withCancel: nil)
    
    }
}

