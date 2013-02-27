Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 27 Feb 2013 18:09:48 +0800
References: <1361022160-25693-1-git-send-email-ordex@autistici.org>
 <1361022160-25693-2-git-send-email-ordex@autistici.org>
In-Reply-To: <1361022160-25693-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201302271809.49037.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/2] batman-adv: remove interfacing
	enslaving loop private check
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Saturday, February 16, 2013 21:42:40 Antonio Quartulli wrote:
> Now that the new dev_upper API is used, the private check for enslaving
> loops is not needed anymore as this is performed by the new API itself.

Are you sure ? Isn't the following supposed to fail:

$ batctl if add eth0
$ vconfig add bat0 5
$ batctl if add bat0.5

$ batctl if
  eth0: active
  bat0.5: active

Or what is the expected behavior ?

Cheers,
Marek
