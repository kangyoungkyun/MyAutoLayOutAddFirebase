
import UIKit

extension SwipingController {
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (_) in
            //원래의 collectionViewLayout 기능을 정지 시킨다.
            self.collectionViewLayout.invalidateLayout()
            //페이지 컨트롤의 현재페이지가 0 이면
            if self.pageControl.currentPage == 0 {
                //오프셋을 .zero 로 설정
                self.collectionView?.contentOffset = .zero
            } else {
                //아니라면 넘겨지는 화면에 맞추기
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
            
        }) { (_) in
            
        }
    }
    
}

