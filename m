Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 26 Apr 2010 05:07:18 +0800
References: <201004252136.25395.adebex@gmail.com>
In-Reply-To: <201004252136.25395.adebex@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201004260507.19020.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Security & node authentication in BATMAN network
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


Hi,

> 1. Does BATMAN provide any method of *authenticating* nodes?
> As I've said earlier, sometimes transferred data will be highly sensitive
>  (for example: information of patients health in hospital), so it's
>  absolutely critical to not allow leaking this information. I can imagine
>  situation when some fake nodes claim "Hey, I'm the server collecting this
>  data"... I think this is also important when someone would try to destroy
>  our mesh network by placing some fake nodes in it.
> 2. If point nr one isn't possible, maybe there is some other way to ensure
> security? I don't know too much about security or cryptography, but I can
> think of solutions such as openVPN or IPsec.

I tend to agree with Andrew: If you wish to secure patient data transfers end-
to-end encryption is probably what you are looking for (e.g. SSL). But 
"ensuring security" is a very broad term which we hear quite often. Please 
check our FAQ: http://www.open-mesh.org/wiki/FAQ

Cheers,
Marek
