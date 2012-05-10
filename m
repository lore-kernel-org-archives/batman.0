Return-Path: <davem@davemloft.net>
Date: Thu, 10 May 2012 12:07:28 -0400 (EDT)
Message-Id: <20120510.120728.1691568555429264215.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <9033916.UuGU18BIPo@bentobox>
References: <1336561976-16088-8-git-send-email-ordex@autistici.org>
	<20120509.204111.1931607501484626500.davem@davemloft.net>
	<9033916.UuGU18BIPo@bentobox>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 07/14] batman-adv: split neigh_new
 function into generic and batman iv specific parts
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
To: sven@narfation.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, lindner_marek@yahoo.de

From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 10 May 2012 09:34:25 +0200

> On Wednesday, May 09, 2012 08:41:11 PM David Miller wrote:
> [...]
>> The namespace pollution of the batman-adv code needs to improve,
>> and I'm putting my foot down starting with this change.
>> 
>> If you have a static function which is therefore private to a
>> source file, name it whatever you want.
>> 
>> But once it gets exported out of that file, you have to give it
>> an appropriate name.  Probably with a "batman_adv_" prefix or
>> similar.
> 
> I aggree, but would like to like to have a shorter prefix batadv_. I know that 
> you said "or similar" but there are still some developers that fear your 
> response to a patch that only adds the prefix batadv_ instead of the longer 
> version.

batadv_ is fine.
