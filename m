Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 28 Apr 2011 19:34:29 +0200
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
	<1303940106-1457-3-git-send-email-ordex@autistici.org>
	<20110428161031.GB4240@lunn.ch>
In-Reply-To: <20110428161031.GB4240@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201104281934.30252.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: improved client
	announcement mechanism
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

On Thursday 28 April 2011 18:10:31 Andrew Lunn wrote:
> Shouldn't this dependency be listed in the Kconfig file? I think you
> need to add
> 
> select CRC16

Actually, the question is whether it is a wise move to introduce this 
dependency just for that function or whether somebody has an idea how to avoid 
it. Obviously, copying this function into our module won't be accepted by the 
kernel developers.

Regards,
Marek
