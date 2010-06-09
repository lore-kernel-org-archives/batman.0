Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 10 Jun 2010 05:11:33 +0800
References: <1275779039-22946-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1275779039-22946-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201006100511.34285.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH-trunk] batman-adv: Mark locally used
	symbols as static
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

On Sunday 06 June 2010 07:03:59 Sven Eckelmann wrote:
> Functions and variables which are used only inside one object file can
> be declared as static. This helped to find unused functions/variables
> 
>  * mainIfAddr_default
>  * main_if_was_up
> 
> and functions with declarations but missing definitions
> 
>  * hash_debug
>  * orig_find
>  * send_own_packet_work

Applied in revision 1695.

Thanks,
Marek
