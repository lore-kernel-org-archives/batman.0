Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 29 May 2011 21:58:33 +0200
References: <1306695271-8749-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1306695271-8749-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201105292158.33513.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: send_*_tt_response() has to
	initialise the ttl field
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

On Sunday 29 May 2011 20:54:31 Antonio Quartulli wrote:
> send_*_tt_response() didn't properly initialise the ttl field of the
> tt_response message.
> 
> This error was introduced with: cea194d90b11aff7fc289149e4c7f305fad3535a

Applied in revision 7fbf38e.

Thanks,
Marek
