Return-Path: <daniele.furlan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201106081210.03034.lindner_marek@yahoo.de>
References: <1307400355-11624-1-git-send-email-daniele.furlan@gmail.com>
	<201106071001.59176.lindner_marek@yahoo.de>
	<BANLkTinO=5LO+Ctss=a05i1Pr-zFsyKEzA@mail.gmail.com>
	<201106081210.03034.lindner_marek@yahoo.de>
Date: Wed, 8 Jun 2011 13:07:05 +0200
Message-ID: <BANLkTinS9zdW8vhs5Fn57eHYRz0cF6DfMg@mail.gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Mark as received also old
	rebroadcast
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

2011/6/8 Marek Lindner <lindner_marek@yahoo.de>:
> On Tuesday, June 07, 2011 10:23:58 AM Daniele Furlan wrote:
>> Running some test with netperf (but also using ping -f the result did
>> not change), it happens that TQ towards all node in the network drops to
>> values near 0. This beahaviuor lead to "random" route change that are not
>> correlated with the quality of the link. I verified that this patch solve
>> this problem.
>
> Thanks for the explanations. I hope you don't mind that I add these
> information to your commit message before submiting it ?

Ok no problem, let's add it to the commit message.

Thank'you!

>
> Regards,
> Marek
>

-- 
Daniele Furlan
