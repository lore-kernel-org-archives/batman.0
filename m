Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 9 Oct 2010 13:41:07 +0200
References: <201009291520.13588.lindner_marek@yahoo.de>
In-Reply-To: <201009291520.13588.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201010091341.08096.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] bridge loop avoidance (v3)
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

On Wednesday 29 September 2010 15:20:13 Marek Lindner wrote:
> the received comments motivated me to reword the commit messages to outline
> that the loop is caused by bridging the payload traffic and not by the LAN
> itself. Furthermore, the locking has been cleaned up and the neighbor list
> is purged when the module is unloaded.

Since no more new questions came up I merged the patches into trunk (revision 
1816-1817). 

Regards,
Marek
