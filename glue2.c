/*	Copyright (c) 1984, 1986, 1987, 1988, 1989 AT&T	*/
/*	  All Rights Reserved  	*/


/*
 * Copyright (c) 1980 Regents of the University of California.
 * All rights reserved. The Berkeley software License Agreement
 * specifies the terms and conditions for redistribution.
 */

/*
 * Copyright (c) 1983, 1984 1985, 1986, 1987, 1988, Sun Microsystems, Inc.
 * All Rights Reserved.
 */

/*	from OpenSolaris "glue2.c	1.3	05/06/02 SMI" 	*/

/*
 * Portions Copyright (c) 2005 Gunnar Ritter, Freiburg i. Br., Germany
 *
 * From Heirloom project "glue2.c	1.3 (gritter) 10/22/05"
 */

/*
 * Portions Copyright (c) 2012 Pierre-Jean Fichet, Amiens, France
 *
 * $Id: glue2.c,v 0.2 2013/03/12 17:20:47 pj Exp pj $
 */


#include <unistd.h>
#include "refer..c"


char refdir[4096];

void
savedir(void)
{
	if (refdir[0]==0)
		getcwd(refdir, sizeof refdir);
}

void
restodir(void)
{
	chdir(refdir);
}
