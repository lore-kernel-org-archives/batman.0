Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 6 Mar 2012 03:52:46 +0800
References: <1330933911-6320-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1330933911-6320-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201203060352.47058.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: avoid ap_isolated check for
	broadcast packet
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

On Monday, March 05, 2012 15:51:51 Antonio Quartulli wrote:
> in case of a broadcast packet, the result of the ap_isolated check is
> always false (since we have no ff:ff:ff:ff:ff:ff client to check for
> TT_CLIENT_WIFI), therefore we can avoid searching the translation table
> and we can return false directly

How about also checking the source address ? You probably also should add 
similar checks for tt_local_add() ? Or do we have "legal" cases in which we 
announce multicast addresses ?

Cheers,
Marek
