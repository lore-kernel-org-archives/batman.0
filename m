Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 7 May 2010 11:14:29 +0800
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
	<201005062344.57242.sven.eckelmann@gmx.de>
In-Reply-To: <201005062344.57242.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201005071114.30601.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 00/26] staging:batman-adv
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
To: b.a.t.m.a.n@lists.open-mesh.org

On Friday 07 May 2010 05:44:06 Sven Eckelmann wrote:
> Am I the only one who thinks that Marek takes credits for too many patches?
> Yes, we all have to praise him for his work, but just noticed those minor
> glitches:
>  * fix whitespace style issues
>    - work from Luis de Bethencourt <luisbg@ubuntu.com>
>  * Fix whitespace problems criticized by
>    Reduce max characters on a line to 80
>    - work from me... somewhat
> 
> Not that I really want credit for those patches (maybe I should have
> submitted them under a different name.....), but that didn't happen in the
> past and now more than one time in a row. What happened here? git-am's
> fault?

It seems there are a couple of patches wrong but I don't know how this initial 
credit list gets created. I had the impression the first "Signed-off-by" is the 
owner of a patch ?

Here is the complete list of incorrect assignments (as far as I can tell):
 * Simon to Linus
 => [PATCH 07/26] staging:batman-adv: Remove dead max addr and obsolete 
VIS_FORMAT strings
 => [PATCH 09/26] staging:batman-adv: Update README about vis raw output

 * Marek to Luis
 => [PATCH 12/26] staging:batman-adv: fix whitespace style issues

 * Marek to Mikal:
 => [PATCH 24/26] staging:batman-adv: Fix whitespace problems criticized by 
checkpatch.pl
 => [PATCH 25/26] staging:batman-adv: Reduce max characters on a line to 80


> And thanks to Andrew for the preparation and submission of that huge
> patchset. 

Many thanks to all that helped making so much progress in that short time 
frame. The new TODO file looks awesome !  :-)

Regards,
Marek
