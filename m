Return-Path: <tracer@robotech.de>
Message-ID: <4E600B22.7090100@robotech.de>
Date: Fri, 02 Sep 2011 00:45:54 +0200
From: Tobias <tracer@robotech.de>
MIME-Version: 1.0
References: <4E5D69E3.30403@robotech.de>
	<CAKeC-QGag_c+g93MbiJWL9HB3iOczbfbatYUAA1wEEFSyvyd2g@mail.gmail.com>
	<20110831160712.GC25149@ritirata.org>
	<201108311816.23147.lindner_marek@yahoo.de>
	<20110831161833.GD25149@ritirata.org>
	<4E5E69DB.5060007@robotech.de>
	<20110831215506.GA27165@ritirata.org>
	<4E5F3F31.7000402@robotech.de> <20110901155545.GA840@ritirata.org>
	<4E5FF4F2.8050309@robotech.de> <20110901213531.GE840@ritirata.org>
In-Reply-To: <20110901213531.GE840@ritirata.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Am 01.09.2011 23:35, schrieb Antonio Quartulli:
> On Thu, Sep 01, 2011 at 11:11:14 +0200, Tobias wrote:
>> root@1043-49:~# batctl l | grep "0a:18:84:1e:f6:05"
> Can you give me the output of batctl tg and batctl tl on this node (1043-49)?

uncut output:

root@1043-49:~# batctl tg
Globally announced TT entries received via the mesh bat0
        Client        (TTVN)       Originator      (Curr TTVN)
  * 42:c9:62:7e:91:f2  (  1) via             bat57     (  1)
  * d6:0f:24:f1:43:3c  (  1) via             bat59     (  1)
  * 04:11:80:50:38:c8  (  1) via             bat53     (  1)
  * 7a:7b:f4:ed:5c:24  (  1) via             bat52     (  1)
  * 04:11:80:2f:c4:c8  (  1) via             bat67     (  1)
  * be:57:9e:5b:e0:3e  (  1) via             bat60     (  1)
  * fa:45:8f:a5:2c:75  (  1) via             bat55     (  1)
  * c2:90:a3:3b:4e:c9  (  1) via             bat58     (  1)
  * ea:4b:dd:55:f3:1f  (  1) via             bat54     (  1)
  * 76:18:e9:ab:f9:40  (  1) via             bat51     (  1)

root@1043-49:~# batctl tl
Locally retrieved addresses (from bat0) announced via TT (TTVN: 1):
  * 9e:90:fc:dc:99:09

> and ouput of batctl tl of this other node (fon-53)?

root@fon-53:~# batctl tl
Locally retrieved addresses (from bat0) announced via TT (TTVN: 1):
  * da:54:2c:e4:b9:1e

Tobias

