Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 7 Feb 2012 02:37:49 +0800
References: <1327258827-13861-1-git-send-email-siwu@hrz.tu-chemnitz.de>
	<1327258827-13861-8-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1327258827-13861-8-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201202070237.50035.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 07/10] batman-adv: add broadcast
	duplicate check
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

On Monday, January 23, 2012 03:00:24 Simon Wunderlich wrote:
> When multiple backbone gateways relay the same broadcast from the
> backbone into the mesh, other nodes in the mesh may receive this
> broadcast multiple times. To avoid this, the crc checksums of
> received broadcasts are recorded and new broadcast packets with
> the same content may be dropped if received by another gateway.

Applied in revision e5cf86d.

Thanks,
Marek
