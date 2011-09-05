Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 5 Sep 2011 10:06:13 +0200
References: <4E5D69E3.30403@robotech.de> <20110901213531.GE840@ritirata.org>
	<4E600B22.7090100@robotech.de>
In-Reply-To: <4E600B22.7090100@robotech.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201109051006.13844.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv 2011.2.0 hop somtimes does not work
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


Tobias,

> root@1043-49:~# batctl tg
> Globally announced TT entries received via the mesh bat0
>         Client        (TTVN)       Originator      (Curr TTVN)
>   * 42:c9:62:7e:91:f2  (  1) via             bat57     (  1)
>   * d6:0f:24:f1:43:3c  (  1) via             bat59     (  1)
>   * 04:11:80:50:38:c8  (  1) via             bat53     (  1)
>   * 7a:7b:f4:ed:5c:24  (  1) via             bat52     (  1)
>   * 04:11:80:2f:c4:c8  (  1) via             bat67     (  1)
>   * be:57:9e:5b:e0:3e  (  1) via             bat60     (  1)
>   * fa:45:8f:a5:2c:75  (  1) via             bat55     (  1)
>   * c2:90:a3:3b:4e:c9  (  1) via             bat58     (  1)
>   * ea:4b:dd:55:f3:1f  (  1) via             bat54     (  1)
>   * 76:18:e9:ab:f9:40  (  1) via             bat51     (  1)
> 
> root@1043-49:~# batctl tl
> Locally retrieved addresses (from bat0) announced via TT (TTVN: 1):
>   * 9e:90:fc:dc:99:09
> 
> > and ouput of batctl tl of this other node (fon-53)?
> 
> root@fon-53:~# batctl tl
> Locally retrieved addresses (from bat0) announced via TT (TTVN: 1):
>   * da:54:2c:e4:b9:1e

I have tried to reproduce your issue but was unsuccessful. Could you help 
narrowing down the cause by providing some more information ? 
For instance:
* What is the simpliest setup that can provoke the issue ? Does it also happen 
if you only involve 2 nodes ? Or 3 / 4 / 5 ? Does the problem go away if you 
reduce the number of interfaces on each node ?
* You provided some logs showing additions / deletions of a non-existing mac 
address and you said this would go away after a while. What do the logs say 
when the problem is about to disappear ?
* Are the nodes that often exhibit this flakiness far apart or direct 
neighbors ? What does the topology look like ? Again, the simplier the setup 
the better.

Regards,
Marek
