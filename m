Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 6 Oct 2009 21:27:42 +0800
References: <200910061328.04894.holger@layer-acht.org>
	<200910061355.49409.sven.eckelmann@gmx.de>
In-Reply-To: <200910061355.49409.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200910062127.42925.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Fwd: Re: Debian extra modules
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Tuesday 06 October 2009 19:55:46 Sven Eckelmann wrote:
> As far as I know it isn't a part which is currently not targeted for
>  linux-2.6 (staging or netdev) as this isn't self contained, but just a
>  "hack" to improve gateway speed with batmand. Marek has to decide what to
>  do with it further.

That is a qood question. It is self-contained as well but I don't think it 
makes much sense bringing it into staging as it is just a "hack".  :)
I'm not sure what the best path forward might be. Does it hurt keeping it the 
way it is ?


> Parts which are important:
>  * TODO list for staging inside batman-adv folder
>  * removed compat.h and remaining LINUX_VERSION_CODE (net_device_ops,
>    unregister_chrdev)
>  * clean Makefile and Kconfig
>  * anyone who says how the further development should be done
>  * anyone who sends the patch to Greg (probably Marek)

I think most of the things listed here are already done. It just needs to come 
together. I'm confident that this will happen soon.


> @Marek: Is the postfix server configured to do greylisting? If yes, do you
> have a some statistics about how many spam mails come through and will be
> kicked out by the mailinglist system? If it isn't that much I would do some
> moderation for some months before we maybe move to a better option.

The postifx setup is quite simple at the moment: It rejects all unknown / 
unregistered mail. Greylisting is not in place yet. I quickly ran pflogsumm to 
give you an impression:

Per-Day Traffic Summary
    date          received  delivered   deferred    bounced     rejected
    --------------------------------------------------------------------
    Sep 27 2009       110        107        153         16       4874
    Sep 28 2009       170        855        298         56       6894
    Sep 29 2009       229       1235        379         90       6757
    Sep 30 2009       176        525        420         38       7477
    Oct  1 2009       187        222        377         20       7913
    Oct  2 2009       132        132        414         17       8086
    Oct  3 2009       112        117        374         18       7790
    Oct  4 2009       128        658        294         42       6158 
    Oct  5 2009       243       1634        509         97       7657

But I tend to agree with you: We might have to face the fact that we have to 
improve the SPAM filter on our end and open the list. As a first step we could 
install greylisting and have a bunch of moderators to see how that goes.

@Jacob: How do you feel about that ?

@Andrew: Would you be willing to join the moderators group ?

Regards,
Marek
