Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 24 Dec 2009 16:56:56 +0800
References: <94CAE17FD1DB4640BF8FF28D61FDFA8A27301B@RESQNAOEX01.qnao.net>
	<200912231436.36971.sven.eckelmann@gmx.de>
	<94CAE17FD1DB4640BF8FF28D61FDFA8A27303A@RESQNAOEX01.qnao.net>
In-Reply-To: <94CAE17FD1DB4640BF8FF28D61FDFA8A27303A@RESQNAOEX01.qnao.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200912241656.56674.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [BULK]  Re:  can't start batmand
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

On Wednesday 23 December 2009 22:56:11 Conner, Eric wrote:
> thanks for the info...I got passed that by installing iptables.

iptables is optional but should help you to avoid well-known issues .


> Now I get a second error
> 
> Error can't flush routing rules: operation not supported

batmand requires the kernel policy routing features enabled.

Regards,
Marek
