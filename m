Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 22 Nov 2011 18:59:37 +0800
References: <CAFevQmPcoR3O5FHfHvuUkv4yrJMYd1MtsEMNZ24uwjXaUtXxeQ@mail.gmail.com>
	<1321803316-18872-1-git-send-email-sven@narfation.org>
In-Reply-To: <1321803316-18872-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201111221859.37599.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Return failure code when ping
	was not successful
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

On Sunday, November 20, 2011 23:35:16 Sven Eckelmann wrote:
> The standard iputils-ping returns an error code when it could not receive a
> single reply to a echo request. batctl ping behaved differently and made it
> only possible to detect that the target is not reachable by parsing the
> text output of batctl.
> 
> A new return code EXIT_NOSUCCESS (2) is introduced to distinguish a general
> failure from the inability to reach another node.

Applied in revision 5f3776a.

Thanks,
Marek
