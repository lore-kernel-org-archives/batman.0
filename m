From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] AHdemo mode
Date: Thu, 10 Apr 2008 08:52:50 +0800
References: <200804092052.12389.gfjl@ubbi.com>
In-Reply-To: <200804092052.12389.gfjl@ubbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804100852.51052.lindner_marek@yahoo.de>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


Hi,

> I found this post : http://robin.forumup.it/about107-robin.html
>
> I like to hear opinions about this possible security issue.

why do the security experts always find the same bug ?  :D

As far as I know the WPA encryption is not supposed to secure _all_ your 
traffic. It is supposed to encrypt the traffic between your notebook and your 
accesspoint. 

For meshing you need ad-hoc mode and in this mode you don't have a single 
authority to authenticate against. How should "mesh encryption" work - all 
nodes are "equal" ?

If you want to secure your network traffic, please use the higher security 
layers as SSL or similar technologies. They do _proper_ end to end 
encryption. Even if the WPA would work your traffic is not secure as the 
internet gateway and all stations after it still could sniff your traffic.

I would be very interested to hear from "williamruckman" what kind of packets 
he would inject to "capture all traffic or perform a man-in-the-middle 
attack". I suggest reading the "security considerations" section of this 
document first:
https://www.open-mesh.net/batman/doc/draft-openmesh-b-a-t-m-a-n-00.txt
 
Regards,
Marek
