//
//  FeedsViewController.swift
//  instagram
//
//  Created by searto  on 10/14/20.
//

import UIKit
import Parse
import AlamofireImage
import BDBOAuth1Manager
//import MessagesInputBar

class FeedsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   // let commentBar = MessageInputBar()
    var selectedPost: PFObject!
    var window: UIWindow?

    @IBOutlet weak var tableView: UITableView!
    var posts = [PFObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        commentBar.inputTextView.placeholder = "Add a comment..."
//        commentBar.sendButton.title = "Post"
//        commentBar.delegate = self
//
        tableView.delegate = self
        tableView.dataSource = self
            // reloadInputViews()
        // Do any additional setup after loading the view.
        tableView.keyboardDismissMode = .interactive
        
        
//        let center = NotificationCenter.default
//        center.addObserver(self, selector: #selector(keyboardwillbeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }

//    @objc func keyboardwillbeHidden(note: Notification)
//    {
//        commentBar.inputTextView.text = nil
//        showCommentBar = false
//        becomeFirstResponder()
//
//    }
    
    
//    override var inputAccessoryView: UIView?{
//        return commentBar
//    }
//    override var canBecomeFirstResponder: Bool{
//        return showCommentBar
//    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


        let query = PFQuery(className: "Posts")
        query.includeKeys(["author", "comments", "comments.author"])
        query.limit = 20
        query.findObjectsInBackground{(posts , error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            }
        }

    }

//    func messgaeInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String)
//    {
//        //create comment
//        let comments = PFObject(className: "comments")
//         comment["text"] = text
//          comment["post"] = selectedPost
//          comment["author"] = PFUser.current()
//          post.add(comment,forKey: "comments")
//
//          post.saveInBackground{(success, error) in
//              if success
//              {
//                  print("comment saved")
//              }
//              else
//              {
//                  print("Error saving comment")
//              }
//            tableView.reloadData()
//
//          }
//        //clear&dismiss input bar
//        commentBar.inputTextView.text = nil
//        showCommentBar = false
//        becomeFirstResponder()
//        commentBar.inputTextView.resignFirstResponder()
//    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let post = posts[section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        return comments.count+2
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        if indexPath.row == 0
        {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell

       
        let user = post ["author"] as! PFUser
        cell.userName.text = user.username
        cell.captionLabel.text = post["caption"] as! String

        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
       
       cell.photoView.af_setImage(withURL: url)

        return cell
        }
       //  if indexPath.row <= comments.count
        //{
            let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! commentCell
            return cell
            
            let comment = comments[indexPath.row-1]
            cell.commentLabel.text = comment["text"] as? String
             let user = comment["author"] as! PFUser
            cell.nameLabel.text = user.username
//        }
//        else
//        {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")
//            return cell
//
//        }
        return cell
    }

   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let post = posts[indexPath.section]
        
        let comments = (post["comments"] as? [PFObject]) ?? []
        
//        if indexPath.row == comments.count + 1
//        {
//            showCommentBar = true
//            becomeFirstResponder()
//            commentBar.inputTextView.becomeFirstResponder()
//
//            selectedPost = post
//        }
        
        
//        comment["text"] = "this is a random comment"
//        comment["post"] = post
//        comment["author"] = PFUser.current()
//        post.add(comment,forKey: "comments")
//
//        post.saveInBackground{(success, error) in
//            if success
//            {
//                print("comment saved")
//            }
//            else
//            {
//                print("Error saving comment")
//            }
//
//        }
        
    }
    
    @IBAction func LogOutButton(_ sender: Any)
    {
        
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let LogInViewController = main.instantiateViewController(withIdentifier: "LogInViewController")
        
   let delegate = UIApplication.shared.delegate as! AppDelegate
        
        delegate.window?.rootViewController = LogInViewController 
        
    }
    

    /*


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
