Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 2 May 2011 17:09:31 +0200
References: <1304348024-11681-1-git-send-email-lindner_marek@yahoo.de>
	<201105021702.33522.sven@narfation.org>
In-Reply-To: <201105021702.33522.sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201105021709.31468.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: purge unnecessary include
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

On Monday 02 May 2011 17:02:32 Sven Eckelmann wrote:
> On Monday 02 May 2011 16:53:44 Marek Lindner wrote:
> > Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> 
> [,,,,]
> 
> >  #include <linux/version.h>   /* LINUX_VERSION_CODE */
> >
> > -#include "bat_sysfs.h"               /* struct bat_attribute */
> 
> This is necessary for kernels older than 2.6.24


Aarrrgh, I was afraid of something like that. We are running into an include 
dependency issue as soon as bat_sysfs.h contains something like "struct 
bat_priv" which is likely to come soon ...
Any better idea how to fix this ?

Regards,
Marek
