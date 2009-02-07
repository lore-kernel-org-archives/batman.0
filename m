From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 7 Feb 2009 12:54:06 +0800
References: <1233939371-23629-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1233939371-23629-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200902071254.06564.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Introduce set/get functions for /proc
	files
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Saturday 07 February 2009 00:56:11 Sven Eckelmann wrote:
> get_integer_file can be used to get an integer from the beginning of a
> file. It does the same as every other get_* function in linux/kernel.c
> has done before, but introduced extra error checking for fscanf to
> deal with the undefined behaviour of it in error cases in c89.

Thanks for your patches. I applied all three of them.

Regards,
Marek

