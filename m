Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 6 Dec 2011 23:30:54 +0800
References: <1323078985-1116-1-git-send-email-lindner_marek@yahoo.de>
	<20111206150134.GA12168@pandem0nium>
	<20111206152106.GJ10131@lunn.ch>
In-Reply-To: <20111206152106.GJ10131@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201112062330.54377.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] switch routing algorithm at runtime
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

> When it is in debugfs, it implies that the user has no choice, it is a
> debug tool only. So when the development is finished, one day batman
> will just swap from IV to V, and the user gets no choice?
> 
> For the moment, i think it is O.K. in debugfs. However, there should
> be some sort of idea how this is going to work when it comes to
> actually mainstream use of V. Is it simply that IV is dead, you need
> to use V now. Or do we give the user a choice and some file under /sys
> to make this choice?

the idea of using debugfs instead of sysfs was to avoid the chicken & egg 
problem (I guess). However, looking at my batman-adv debugfs entry tells me 
that we have the same problem there. Unless we want to move this file into the 
debugfs batman-adv root folder (/sys/kernel/debug/batman_adv) we can't move 
forward either. The whole init/config structure has been designed for "create 
bat0 first". 

If we don't want to rewrite this whole part I only see 2 options: 
 * compile or module parameter
 * changing the routing algo on the fly

Regards,
Marek
