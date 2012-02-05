Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 6 Feb 2012 02:40:58 +0800
References: <1326223162-15181-1-git-send-email-sven@narfation.org>
	<1328373293-1783-1-git-send-email-sven@narfation.org>
In-Reply-To: <1328373293-1783-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201202060240.58643.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFCv2] batman-adv: Replace bitarray operations
	with bitmap
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

On Sunday, February 05, 2012 00:34:52 Sven Eckelmann wrote:
> bitarray.c consists mostly of functionality that is already available as
> part of the standard kernel API. batman-adv could use architecture
> optimized code and reduce the binary size by switching to the standard
> functions.

Applied in revision a9f0721.

Thanks,
Marek
