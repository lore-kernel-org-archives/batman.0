Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 23 Oct 2010 17:21:17 +0200
References: <1287846695-17402-1-git-send-email-lindner_marek@yahoo.de>
	<201010231719.23353.sven.eckelmann@gmx.de>
In-Reply-To: <201010231719.23353.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Message-Id: <201010231721.17921.lindner_marek@yahoo.de>
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: remove obsolete flags
	variable to avoid kernel warnings
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

On Saturday 23 October 2010 17:19:21 Sven Eckelmann wrote:
> Correct. Forgot them because I only build it in non-debug mode.

Same here - I missed these warnings when I checked your patch before 
submitting it. Just applied this patch (revision 1848).

Regards,
Marek
