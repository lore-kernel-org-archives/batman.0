Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 3 Apr 2010 17:44:28 +0800
References: <201003241252.18954.lindner_marek@yahoo.de>
	<20100401172810.GA28422@Linus-Debian>
In-Reply-To: <20100401172810.GA28422@Linus-Debian>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201004031744.28756.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] reorganized kernel interface patches (version 3)
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


Hey,

thanks a lot for testing and your feedback!

> had a look at your patches and found a bug which causes a kernel panic
> (see attachement). I can reproduce this with the following veeery
> complicated routine :):
> ---
> ifconfig bat0 down && ifconfig bat0 up
> ---

I tried that but it does not crash at my end. Maybe you did more than you 
think to provoke this crash ? In my test setup I have 2 nodes with 3 
interfaces each. I ran your command several times without seeing any odd 
behaviour.


> The adding and deleting of mesh-port interfaces seems to work fine,
> the new, more dynamic interface is awesome :). And I just was
> wondering if you forgot about adding something like "batctl if del
> all" or did you schedule this for another patch?

Actually, a "delete all" was not on my agenda.


> Also some additional abbrevations for add/del would be nice (just
> "a" and "d" for instance).

Should be no problem - I'll add it before submitting the patches.

Regards,
Marek
