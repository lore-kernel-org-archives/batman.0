Return-Path: <andrew@lunn.ch>
Date: Mon, 1 Mar 2010 07:06:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100301060651.GD15286@lunn.ch>
References: <201002280430.09575.lindner_marek@yahoo.de>
	<1267302649-22040-1-git-send-email-lindner_marek@yahoo.de>
	<1267302649-22040-2-git-send-email-lindner_marek@yahoo.de>
	<20100301015103.GA6602@Linus-Debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100301015103.GA6602@Linus-Debian>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batctl: follow /proc to sysfs
 conversion & introduce input validation
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

> The second thing is, I'm getting two harmless compile time
> warnings on the Debian stable VM here:
> - bat-hosts.c:79/functions.c:174: warning: implicit declaration of function
>   getline

getline(3) is a GNU extension. The man page says:

#define _GNU_SOURCE
#include <stdio.h>

ssize_t getline(char **lineptr, size_t *n, FILE *stream);

I guess it compiles fine on uclibc without the _GNU_SOURCE, but glibc
wants you to explicitly enable the extension so you know you are not
POSIX compatible.

BTW: batctl has used this for a while now. Anybody had problems with
this GNU extension? Is it available for all the C libraries used in
embedded systems which use BATMAN?

      Andrew
