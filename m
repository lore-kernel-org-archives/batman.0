Return-Path: <keinepostnurmuell@gmail.com>
MIME-Version: 1.0
Date: Thu, 19 Nov 2015 15:04:56 +0100
Message-ID: <CAKrZ8yf8rKK__5gNsUncjt59zR7T+wuVx2x+DHQELdqWVz6DxA@mail.gmail.com>
From: no name <keinepostnurmuell@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] batctl file errors
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

I am using BATMAN on a raspberry pi b+ with a kernel version of
4.1.13+ but my problem also occured on an older kernel (I tried
updating, which did not help). My BATMAN is on batctl
debian-2012.1.0-1 [batman-adv: 2015.0].


I try to get the vis_mode up and running, which fails in multiple
ways, because I can't even create logs.

sudo batctl loglevel -> "Error - can't open file
'/sys/class/net/bat0/mesh/log_level': No such file or directory"

sudo batctl vm -> "Error - can't open file
'/sys/class/net/bat0/mesh/log_level': No such file or directory"

and so on. The thing is, when I try:

sudo batmand s -> "Not using interface s (retrying later): interface
not active" whereas if I try:

sudo batmand s IP bat0 -> batman cannot be pinged from any other
interface any more

did I forget to install something?

Thanks
Richard
