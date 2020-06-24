let SIZE: Int = 26;
let ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
var M: Int = 3
var N: Int = 3
var findSet = Set<String>()
class TrieNode {
    var children = [TrieNode?]( repeating: nil, count: SIZE)
    var isFinal: Bool = false
}
func insert(root:TrieNode, word:String){
    var pChild:TrieNode = root
    for letter in word{
      let index = ALPHABET.firstIndex(of: letter)?.utf16Offset(in:ALPHABET)
      if (pChild.children[index!] == nil ){
        pChild.children[index!] = TrieNode();
      }  
       
      pChild = pChild.children[index!]!;
    }
    pChild.isFinal = true
}
func inRange(x:Int, y:Int, isSeen:[[Bool]]) -> Bool{
  return (x>=0 && x<M && y>=0 && y<N && !isSeen[x][y])
}
func searchWord(root:TrieNode, boggle:[[String]], i:Int, 
        j: Int, isSeen: inout [[Bool]], str:String){

  if (root.isFinal == true){
    findSet.insert(str)
  }        
  if (inRange(x:i, y:j, isSeen:isSeen)){ 
    isSeen[i][j] = true; 

    for K in 0...(SIZE-1){ 
        if (root.children[K] != nil){ 
            var ch:String
            var sequence = ALPHABET.unicodeScalars.map{String($0)}
            ch = sequence[K]
            if (inRange(x:i+1,y:j+1,isSeen:isSeen)
                && boggle[i+1][j+1] == ch){
              searchWord(
                root:root.children[K]!,
                boggle:boggle,
                i:i+1,
                j:j+1,
                isSeen:&isSeen,
                str:str + ch
                )
            }
            if (inRange(x:i,y:j+1,isSeen:isSeen)
                && boggle[i][j+1] == ch){
              searchWord(
                root:root.children[K]!,
                boggle:boggle,
                i:i,
                j:j+1,
                isSeen:&isSeen,
                str:str + ch
                )
            }
            if (inRange(x:i-1,y:j+1,isSeen:isSeen)
                && boggle[i-1][j+1] == ch){
              searchWord(
                root:root.children[K]!,
                boggle:boggle,
                i:i-1,
                j:j+1,
                isSeen:&isSeen,
                str:str + ch
                )
            }
            if (inRange(x:i+1,y:j,isSeen:isSeen)
                && boggle[i+1][j] == ch){
              searchWord(
                root:root.children[K]!,
                boggle:boggle,
                i:i+1,
                j:j,
                isSeen:&isSeen,
                str:str + ch
                )
            }
            if (inRange(x:i+1,y:j-1,isSeen:isSeen)
                && boggle[i+1][j-1] == ch){
              searchWord(
                root:root.children[K]!,
                boggle:boggle,
                i:i+1,
                j:j-1,
                isSeen:&isSeen,
                str:str + ch
                )
            }
            if (inRange(x:i,y:j-1,isSeen:isSeen)
                && boggle[i][j-1] == ch){
              searchWord(
                root:root.children[K]!,
                boggle:boggle,
                i:i,
                j:j-1,
                isSeen:&isSeen,
                str:str + ch
                )
            }
            if (inRange(x:i-1,y:j-1,isSeen:isSeen)
                && boggle[i-1][j-1] == ch){
              searchWord(
                root:root.children[K]!,
                boggle:boggle,
                i:i-1,
                j:j-1,
                isSeen:&isSeen,
                str:str + ch
                )
            }
            if (inRange(x:i-1,y:j,isSeen:isSeen)
                && boggle[i-1][j] == ch){
              searchWord(
                root:root.children[K]!,
                boggle:boggle,
                i:i-1,
                j:j,
                isSeen:&isSeen,
                str:str + ch
                )
            }
          }
      }
      isSeen[i][j] = false; 
    }
  }
  func findWord(boggle: [[String]], root: TrieNode){
  var isSeen = Array(repeating: Array(repeating: false, count: N),
  count: M)
  let pChild:TrieNode = root
  var str: String = ""
  for i in 0...(M-1){ 
    for j in 0...(N-1){
        let index = ALPHABET.map(String.init).firstIndex(of:boggle[i][j])
        if (pChild.children[index!] != nil){   
            str = str + boggle[i][j];
            searchWord(
              root:pChild.children[index!]!, 
              boggle:boggle,
              i:i,
              j:j,
              isSeen:&isSeen,
              str:str); 
            str = ""; 
        }
    } 
  }
}


let words = readLine()?.uppercased().split{$0 == " "}.map(String.init)
let input = readLine()
if let puzzleDiminput = input {
    let inputChars = puzzleDiminput.split(separator: " ")
    let puzzleDimentions = inputChars.map { Int(String($0))! }
    M = puzzleDimentions[0]
    N = puzzleDimentions[1]
    
    var table = [[String]]()
    for _ in 1...M {
    var aux = [String]()

    readLine()?.uppercased().split(separator: " ").map({
        if aux.count < N {
          aux.append(String($0))
        }
    })
    table.append(aux)
    }
  let root: TrieNode = TrieNode()
  for word in words! {
    insert(root: root, word: word)
  }
  findWord(boggle: table, root: root)
  for word in findSet{
    print(word)
  }
}
